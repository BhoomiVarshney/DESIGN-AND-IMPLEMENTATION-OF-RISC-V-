`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Accumulator(clock, reset, adder_out, acc_out);
    input clock, reset;
    input [63:0] adder_out;
    output reg [63:0] acc_out;
    
    always @(posedge reset, posedge clock)
        begin
            if (reset == 1)
                acc_out <= 64'h0000000000000000;
            else 
                acc_out <= adder_out;
        end
endmodule
