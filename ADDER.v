`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ADDER(acc_out, MUL_reg_out, adder_out);
    
    input [63:0] acc_out, MUL_reg_out;
    output [63:0] adder_out;
    
    assign adder_out = acc_out + MUL_reg_out; 

endmodule
