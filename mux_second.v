`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mux_second(mux2_ctrl, operand1, pc, mux2_out);
    input [31:0] operand1, pc; 
    input mux2_ctrl; 
    output [31:0] mux2_out;
    
    assign mux2_out = (mux2_ctrl ? operand1 : pc);
    
endmodule
