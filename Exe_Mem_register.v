`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Exe_Mem_register(clock, reset, rd_field, mux5_out, pc_value, is_load, is_store, is_call, reg_write, is_auipc, rs2_value, should_branch, load_variant, store_variant, E_M_register);
    
    input clock, reset, is_load, is_store, is_call, reg_write, is_auipc, should_branch;
    input [4:0] rd_field; 
    input [2:0] load_variant, store_variant;
    input [31:0] mux5_out, pc_value, rs2_value;
    output reg [112:0] E_M_register;
    
    always @(posedge clock, posedge reset)
        begin
            if (reset == 1)
                E_M_register <= 0;
            else 
                E_M_register <= {store_variant, load_variant, should_branch, rs2_value, is_auipc, reg_write, is_call, is_store, is_load, pc_value, mux5_out, rd_field};         
        end
    
endmodule