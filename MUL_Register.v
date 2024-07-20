`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module MUL_Register(clock, reset, mul_output, MUL_reg_out);
    input clock, reset;
    input [63:0] mul_output;
    output reg [63:0] MUL_reg_out;
    
    always @(posedge reset, posedge clock)
        begin
            if (reset == 1)
                MUL_reg_out <= 64'h0000000000000000;
            else 
                MUL_reg_out <= mul_output;
        end 
    
endmodule
