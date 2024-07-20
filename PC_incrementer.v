`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PC_incrementer(address_bus_IR, pc_in);
    input [31:0] address_bus_IR;
    output [31:0] pc_in;
    
    assign pc_in = address_bus_IR + 4;
    
endmodule
