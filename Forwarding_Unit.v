`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Forwarding_Unit(rs1_field, rs2_field, ex_mem_rd, mem_wb_rd, operand1_select, operand2_select, is_writeback_em, is_writeback_mwb);
    input [4:0] rs1_field, rs2_field, ex_mem_rd, mem_wb_rd;
    input is_writeback_em, is_writeback_mwb;
    output reg [1:0] operand1_select, operand2_select;
    
    always @(*)
        begin
           operand1_select = 2'b00;
           operand2_select = 2'b00;
                    if ((is_writeback_mwb==1) & (mem_wb_rd == rs1_field))
                        operand1_select = 2'b11;
                    if ((is_writeback_mwb==1) & (mem_wb_rd == rs2_field))
                        operand2_select = 2'b11;
                    if ((is_writeback_em==1) & (ex_mem_rd == rs1_field))
                        operand1_select = 2'b10;
                    if ((is_writeback_em==1) & (ex_mem_rd == rs2_field))
                        operand2_select = 2'b10;
        end
endmodule
