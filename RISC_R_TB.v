`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module RISC_R_TB();

     reg clock, reset;
     wire [31:0] address_bus_IR, inst_mem_bus_IR, reg1_out, reg2_out, alu_partialresult, inter_result, final_result;
     RISC_R_main rdatapath(clock, final_result, reset, address_bus_IR, inst_mem_bus_IR, reg1_out, reg2_out, alu_partialresult, inter_result);

     initial
        begin
            #0 clock = 1'b0; #0 reset = 1'b1;
            #2 reset = 1'b0;
            #3 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #5 clock = ~clock;
            #1 $finish;
        end
endmodule
