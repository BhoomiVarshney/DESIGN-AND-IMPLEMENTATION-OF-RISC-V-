`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC_Register(clock, reset, pc_hold, pc_in_actual, address_bus_IR);
    input clock, reset, pc_hold;
    input [31:0] pc_in_actual;
    output reg [31:0] address_bus_IR;
    
    always @(posedge clock, posedge reset)
        begin
            if (reset==1)
                address_bus_IR <= 32'h00000000;
            else if (pc_hold == 0)
                address_bus_IR <= pc_in_actual;
            else 
                address_bus_IR <= address_bus_IR;
        end       
endmodule
