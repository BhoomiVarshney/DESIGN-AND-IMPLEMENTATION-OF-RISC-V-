`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Mem_WB_register(clock, reset, rd_field, load_data, pc, is_call, writeback, M_WB_register);
    input clock, reset, is_call, writeback;
    input [31:0] load_data, pc;
    input [4:0] rd_field;
    output reg [70:0] M_WB_register;
    
    always @(posedge clock, posedge reset)
        if (reset==1)
            M_WB_register = 0;
        else
            M_WB_register = {writeback, is_call, pc, load_data, rd_field};
endmodule
