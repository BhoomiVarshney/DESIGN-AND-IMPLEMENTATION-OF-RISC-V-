`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mux_fifth(is_branch, mux4_out, BT, mux5_out);
    
    input [31:0] mux4_out, BT; 
    input is_branch; 
    output [31:0] mux5_out;
    
    assign mux5_out = (is_branch ? BT : mux4_out);
    
endmodule
