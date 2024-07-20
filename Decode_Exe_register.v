`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Decode_Exe_register(clock, reset, DE_register_reset, rd_field, branch_target, immediate_final, reg1_out, reg2_out, pc_value, alu_ctrl, mux2_ctrl, mux3_ctrl, is_uformat, is_branch, sb_kind, is_load, is_store, is_call, reg_write, is_auipc, load_variant, store_variant, rs1_field, rs2_field, D_E_register);
    
    input clock, reset, DE_register_reset, mux2_ctrl, mux3_ctrl, is_uformat, is_branch, is_load, is_store, is_call, reg_write, is_auipc;
    input [3:0] alu_ctrl;
    input [2:0] sb_kind, load_variant, store_variant;
    input [4:0] rd_field, rs1_field, rs2_field; 
    input [31:0] immediate_final, branch_target, reg1_out, reg2_out, pc_value;
    output reg [196:0] D_E_register;
    
    always @(posedge clock, posedge reset)
        begin
            if ((reset == 1) || (DE_register_reset == 1))
                D_E_register <= 0;
            else 
                D_E_register <= {rs2_field, rs1_field, store_variant, load_variant, is_auipc, reg_write, is_call, is_store, is_load, sb_kind, is_branch, is_uformat, mux3_ctrl, mux2_ctrl, alu_ctrl, pc_value, reg2_out, reg1_out, immediate_final, branch_target, rd_field};         
        end
    
endmodule
