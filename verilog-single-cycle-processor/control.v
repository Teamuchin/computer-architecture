module control(in, f, regdest, alusrc, memtoreg, regwrite, 
               memread, memwrite, branch, aluop1, aluop2, jump, bne);
input [7:0] in;
input [5:0] f;

output wire regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop1, aluop2, jump, bne;

wire rformat,lw,sw,beq,j;

assign rformat = (~in[7]) & in[6] & (~in[5]) & in[4] & in[3] & in[2] & in[1] & in[0]; //01011111 =95

assign lw = (~in[7]) & in[6] & in[5] & (~in[4]) & (~in[3]) & (~in[2]) & (~in[1]) & (~in[0]); //01100000 =96

assign sw = (~in[7]) & in[6] & in[5] & (~in[4]) & (~in[3]) & (~in[2]) & (~in[1]) & in[0]; //01100001 =97

assign beq = (~in[7]) & in[6] & in[5] & (~in[4]) & (~in[3]) & (~in[2]) & in[1] & (~in[0]); //01100010 =98

assign bne = (~in[7]) & in[6] & in[5] & (~in[4]) & (~in[3]) & (~in[2]) & in[1] & in[0]; //01100011 =99

assign addi = (~in[7]) & in[6] & in[5] & (~in[4]) & (~in[3]) & in[2] & (~in[1]) & (~in[0]); //01100100 =100

assign j = (~in[7]) & in[6] & in[5] & (~in[4]) & (~in[3]) & in[2] & (~in[1]) & in[0]; //01100101 =101


assign regdest = rformat;
assign regwrite = rformat | lw | addi;
assign memtoreg = lw;
assign alusrc = lw|sw|addi;
assign memread = lw;
assign memwrite = sw;
assign branch = beq;
assign aluop1 = rformat;
assign aluop2 = beq|bne;
assign jump = j;


endmodule