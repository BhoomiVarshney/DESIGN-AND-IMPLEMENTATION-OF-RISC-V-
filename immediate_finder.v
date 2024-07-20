`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module immediate_finder(pc_value, mux1_ctrl, I_immediate, s_immediate, u_immediate, sb_immediate, uj_immediate, immediate_final, branch_target);
    input [31:0] pc_value, I_immediate, s_immediate, u_immediate, sb_immediate, uj_immediate;
    input [2:0] mux1_ctrl;
    output reg [31:0] immediate_final, branch_target;
    
    
    always @(mux1_ctrl, I_immediate, s_immediate, u_immediate, sb_immediate, uj_immediate) 
        begin
            case (mux1_ctrl)
                3'b000 : immediate_final = I_immediate;
                3'b001 : immediate_final = s_immediate;
                3'b010 : immediate_final = u_immediate;
                3'b011 : immediate_final = sb_immediate;
                3'b100 : immediate_final = uj_immediate;
                default : immediate_final = 32'h00000000;
            endcase
            branch_target = pc_value + immediate_final;
        end
endmodule
