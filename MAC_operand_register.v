`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module MAC_operand_register(clock, reset, first_operand, second_operand, MOR_out);
    input clock, reset;
    input [31:0] first_operand, second_operand;
    output reg [63:0] MOR_out;
    
    always @(posedge reset, posedge clock)
        begin
            if (reset == 1)
                MOR_out <= 64'h0000000000000000;
            else 
                MOR_out <= {second_operand, first_operand};
        end 
endmodule
