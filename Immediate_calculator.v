`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Immediate_calculator(dest_reg, source_reg1, source_reg2, funct3, funct7, I_immediate, s_immediate, u_immediate, sb_immediate, uj_immediate);
    input [4:0] dest_reg, source_reg1, source_reg2;
    input [2:0] funct3;
    input [6:0] funct7;
    output [31:0] I_immediate, s_immediate, u_immediate, sb_immediate, uj_immediate;
    
    assign I_immediate = {{20{funct7[6]}}, funct7, source_reg2};
    assign s_immediate = {{20{funct7[6]}}, funct7, dest_reg};
    assign u_immediate = {funct7, source_reg2, source_reg1, funct3, {12{1'b0}}};
    assign sb_immediate = {{19{funct7[6]}}, funct7[6], dest_reg[0], funct7[5:0], dest_reg[4:1], 1'b0};
    assign uj_format = {{11{funct7[6]}}, funct7[6], source_reg1, funct3, source_reg2[0], funct7[5:0], source_reg2[4:1], 1'b0};
    
endmodule
