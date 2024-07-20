`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ALU(alu_ctrl, mux2_out, mux3_out, alu_partialresult);
    input [31:0] mux2_out, mux3_out;
    input alu_ctrl;
    output reg [31:0] alu_partialresult;
    
    always@(*)
        begin
            case (alu_ctrl)
                4'b0000 : alu_partialresult = mux2_out + mux3_out; 
                4'b0001 : alu_partialresult = mux2_out - mux3_out;
                4'b0111 : alu_partialresult = mux2_out^mux3_out;
                4'b1000 : alu_partialresult = mux2_out | mux3_out;
                4'b1001 : alu_partialresult = mux2_out & mux3_out;
                default : alu_partialresult = 0; 
             endcase
        end
endmodule
