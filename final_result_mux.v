`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module final_result_mux(load_data, pc, is_call, final_result);
    input [31:0] load_data, pc;
    input is_call;
    output [31:0] final_result;
    
    assign final_result = is_call ? pc+4 : load_data;
    
endmodule
