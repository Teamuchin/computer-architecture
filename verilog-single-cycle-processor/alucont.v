module alucont(aluop1,aluop2,f3,f2,f1,f0,gout);
input aluop1,aluop2,f3,f2,f1,f0;
output [2:0] gout;
reg [2:0] gout;

always @(aluop1 or aluop2 or f3 or f2 or f1 or f0)
begin
	if(~(aluop1|aluop2))
		gout=3'b010; //add
	if(aluop2)
		gout=3'b011; //sub
	if(aluop1)
	begin
		case({f3, f2, f1, f0})
            	4'b0000: gout = 3'b010;  // add
            	4'b0001: gout = 3'b101;  // Shift Left Logical (SLL)
            	4'b0010: gout = 3'b110;  // Shift Right Logical (SRL)
            	4'b0011: gout = 3'b100;  // NOR
            	4'b0100: gout = 3'b011;  // sub
            	4'b0101: gout = 3'b001;  // OR
            	4'b0110: gout = 3'b111;  // set less than
            	default: gout = 3'b010;  // default to add
        endcase
	end
end
endmodule


