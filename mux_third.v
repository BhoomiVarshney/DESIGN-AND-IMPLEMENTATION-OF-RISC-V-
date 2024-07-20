`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mux_third(mux3_ctrl, operand2, immediate, mux3_out);
    input [31:0] operand2, immediate; 
    input mux3_ctrl; 
    output [31:0] mux3_out;
    
    assign mux3_out = (mux3_ctrl ? operand2 : immediate);
    
endmodule
