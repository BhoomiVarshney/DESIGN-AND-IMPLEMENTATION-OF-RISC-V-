`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Hazard_Operand1_Select(operand1_select, rs1_value, E_M_rs1, M_WB_rs1, mux_second_op);
    input [31:0] rs1_value, E_M_rs1, M_WB_rs1;
    input [1:0] operand1_select;
    output reg [31:0] mux_second_op;
    
    always @(*)
        case (operand1_select)
            2'b00 : mux_second_op = rs1_value;
            2'b01 : mux_second_op = rs1_value;
            2'b10 : mux_second_op = E_M_rs1;
            2'b11 : mux_second_op = M_WB_rs1;
        endcase
endmodule
