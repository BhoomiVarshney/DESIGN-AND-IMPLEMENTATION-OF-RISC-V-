`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module pc_mux(pc_in, branch_address, is_call, is_auipc, should_branch, pc_in_actual);
    input [31:0] pc_in, branch_address;
    input is_call, is_auipc, should_branch;
    output reg [31:0] pc_in_actual;
    
    always @(*)
        if ((is_call==1) || (is_auipc==1) || (should_branch==1))
            pc_in_actual = branch_address;
        else
            pc_in_actual = pc_in;
endmodule
