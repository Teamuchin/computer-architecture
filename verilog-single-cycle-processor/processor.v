module processor;

reg clk;

reg [31:0] pc;

reg [7:0] datmem[0:63], mem[0:31];

wire [31:0] dataa, datab;

wire [31:0] out2, out3, out4, out6; 

wire [31:0] sum, extad, adder1out, adder2out, sextad, jump_address;
wire [23:0] inst23_0;
wire [7:0] inst31_24;
wire [3:0] inst23_20, inst19_16, inst15_12, out1;
wire [15:0] inst15_0;
wire [31:0] instruc, dpack;
wire [2:0] gout;

wire zout, pcsrc, regdest, alusrc, memtoreg, regwrite, memread,
      memwrite, branch, aluop1, aluop2, jump, bne;

reg [31:0] registerfile [0:15];  // from 32 to 16 registers
integer i, c;
reg [31:0] t_mem; 


// JALFOR state tracking
reg jalfor_active;
reg [3:0] jalfor_nr;
reg [3:0] jalfor_necl;
reg [31:0] jalfor_orig_pc;
reg [31:0] jalfor_target_pc;
reg [3:0] jalfor_current_iteration;
reg [3:0] jalfor_lines_executed;




// Updated data memory connections
always @(posedge clk)
begin
    if(memwrite)
    begin 
        datmem[sum[5:0]+3] <= datab[7:0];
        datmem[sum[5:0]+2] <= datab[15:8];
        datmem[sum[5:0]+1] <= datab[23:16];
        datmem[sum[5:0]] <= datab[31:24];
    end
end

// Instruction memory
assign instruc = {mem[pc[4:0]], mem[pc[4:0]+1], mem[pc[4:0]+2], mem[pc[4:0]+3]};

assign inst31_24 = instruc[31:24];  // opcode
assign inst23_20 = instruc[23:20];  // rs
assign inst19_16 = instruc[19:16];  // rt
assign inst15_12 = instruc[15:12];  // rd
assign inst15_0 = instruc[15:0];    // immediate/address for I-type
assign inst23_0 = instruc[23:0];    // address for j-type

// Registers
assign dataa = registerfile[inst23_20];
assign datab = registerfile[inst19_16];

// Data memory pack
assign dpack =  memread ? {datmem[sum[5:0]], datmem[sum[5:0]+1], datmem[sum[5:0]+2], datmem[sum[5:0]+3]} : 32'b0;

// Jump address calculation
assign jump_address = {pc[31:24], inst23_0};

// Multiplexers
mult2_to_1_5 mult1(out1, instruc[19:16], instruc[15:12], regdest);
mult2_to_1_32 mult2(out2, datab, extad, alusrc);
mult2_to_1_32 mult3(out3, sum, dpack, memtoreg);
mult2_to_1_32 mult4(out4, adder1out, adder2out, pcsrc);
mult2_to_1_32 mult6(out6, out4, jump_address, jump);



// jalfor PC and Register Management
always @(posedge clk)
begin
    if (jalfor_active) begin
        if (jalfor_lines_executed < jalfor_necl) begin
            pc = pc + 4;
            jalfor_lines_executed = jalfor_lines_executed + 1;
        end else begin
            jalfor_lines_executed = 1;
            jalfor_current_iteration = jalfor_current_iteration + 1;
            if (jalfor_current_iteration < jalfor_nr) begin
                pc = jalfor_target_pc;
            end else begin
                pc = jalfor_orig_pc;
                jalfor_active = 0;
            end
        end
    end else begin
        pc = out6;
        if (instruc[31:24] == 8'b01100110) begin
            jalfor_active = 1;
            jalfor_nr = instruc[23:20];
            jalfor_necl = instruc[19:16];
            jalfor_target_pc = {16'b0, instruc[15:0]};
            jalfor_orig_pc = pc;
            jalfor_current_iteration = 0;
            jalfor_lines_executed = 1;
            pc = jalfor_target_pc;
        end
    end
end



// Register write logic
always @(posedge clk)
begin
    if (regwrite) begin
        registerfile[out1] <= memtoreg ? dpack : out3;
    end
    if (jalfor_active && jalfor_current_iteration == 0 && jalfor_lines_executed == 1) begin
        registerfile[4'b1111] = jalfor_orig_pc;
    end
end


// ALU, adder, and control logic
alu32 alu1(sum, dataa, out2, zout, gout);
adder add1(pc, 32'h4, adder1out);
adder add2(adder1out, sextad, adder2out);

control cont(instruc[31:24],instruc[5:0],regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,
aluop1,aluop2,jump, bne);

signext sext(instruc[15:0], extad);

alucont acont(aluop1,aluop2,instruc[3],instruc[2], instruc[1], instruc[0],gout);

shift shift2(sextad, extad);

assign pcsrc = (branch && zout) || (bne && !zout);

// initialize data memory, instruction memory, and registers
initial
begin
    $readmemh("initDM.dat", datmem);
    $readmemh("initIM.dat", mem);
    $readmemh("initReg.dat", registerfile);

    for(i=0; i<16; i=i+1)
    $display("Instruction Memory[%0d]= %h  ",i,mem[i], "Data Memory[%0d]= 0x%h   ", i, datmem[i], "Register[%0d]= %h", i, registerfile[i]);
	 // Initialize jalfor variables
    	jalfor_active = 0;
		jalfor_nr = 0;
    	jalfor_necl = 0;
    	jalfor_orig_pc = 0;
    	jalfor_target_pc = 0;
    	jalfor_current_iteration = 0;
    	jalfor_lines_executed = 1;
	
    	c = 0;
    	t_mem = 0;

    	for (i = 0; i < 31; i = i + 1) begin
        t_mem = {t_mem[23:0], mem[i]}; 
        c = c + 1;
        if (c == 4) begin
            c = 0;
            $display("Instruction Memory[%0d]= 0x%h [%b %b %b %b %b %b]",i - 3, t_mem,t_mem[31:24], t_mem[23:20],t_mem[19:16], t_mem[15:12],t_mem[5:0], t_mem[15:0]);
            t_mem = 0; 
        end
    end
end


initial
begin
    pc = 0;
    #600 $finish;  //600ps
end


initial
begin
    clk = 0;
    forever #20 clk = ~clk;
end


initial 
begin
    $monitor($time, " PC %h [%d]", pc, pc,"  SUM %h", sum,"  INST %h [%b %b %b %b %b %b]", instruc[31:0], inst31_24, inst23_20, inst19_16, inst15_12, instruc[5:0], inst15_0,"   REGISTER %h %h %h %h", registerfile[4], registerfile[5],registerfile[6], registerfile[1]);
end

endmodule
