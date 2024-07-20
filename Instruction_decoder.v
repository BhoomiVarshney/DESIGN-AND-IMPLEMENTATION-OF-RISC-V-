`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Instruction_decoder(instruction, dest_reg, source_reg1, source_reg2, opcode, funct3, funct7);
    input [31:0]instruction;
    output [4:0]dest_reg, source_reg1, source_reg2;
    output [6:0] opcode;
    output [2:0] funct3;
    output [6:0] funct7;
    
    assign source_reg1 = instruction[19:15];
    assign source_reg2 = instruction[24:20];
    assign dest_reg = instruction[11:7];
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
endmodule
