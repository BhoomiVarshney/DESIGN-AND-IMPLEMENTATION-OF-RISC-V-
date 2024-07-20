`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Hazard_Operand2_Select(operand2_select, rs2_value, E_M_rs2, M_WB_rs2, mux_third_op);
    input [31:0] rs2_value, E_M_rs2, M_WB_rs2;
    input [1:0] operand2_select;
    output reg [31:0] mux_third_op;
    
    always @(*)
        case (operand2_select)
            2'b00 : mux_third_op = rs2_value;
            2'b01 : mux_third_op = rs2_value;
            2'b10 : mux_third_op = E_M_rs2;
            2'b11 : mux_third_op = M_WB_rs2;
        endcase
endmodule
