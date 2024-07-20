`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mux_fourth(is_uformat, alu_partialresult, immediate, mux4_out);
    
    input [31:0] alu_partialresult, immediate; 
    input is_uformat; 
    output [31:0] mux4_out;
    
    assign mux4_out = (is_uformat ? immediate : alu_partialresult);
    
endmodule
