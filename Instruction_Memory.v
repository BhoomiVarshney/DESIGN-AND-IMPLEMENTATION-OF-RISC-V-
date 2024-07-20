`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Instruction_Memory(reset, address_bus_IR, inst_mem_bus_IR);
    input [31:0] address_bus_IR;
    input reset;
    output reg [31:0] inst_mem_bus_IR;
 //   wire [6:0] address_RAM;
    reg [7:0] RAM [0:127];
    integer i;
    
    always @(posedge reset) 
        begin
            for (i=0; i<128; i = i+1)
                RAM[i] = 0;
            RAM[0] = 8'h00;  // Instruction_1_________ADD R1, R2, R3
            RAM[1] = 8'h31;  
            RAM[2] = 8'h00;  
            RAM[3] = 8'hB3;  
            RAM[4] = 8'h00;  // Instruction_2__________ADD R4, R1, R3
            RAM[5] = 8'h30;  
            RAM[6] = 8'h82;  
            RAM[7] = 8'h33;
            RAM[8] = 8'h01;   // Instruction_3_________Ld R4, R0, 30
            RAM[9] = 8'hE0;  
            RAM[10] = 8'h02;  
            RAM[11] = 8'h03;
            RAM[12] = 8'h00;  // Instruction_4__________ADD, R5, R4, R1
            RAM[13] = 8'h12;  
            RAM[14] = 8'h02;  
            RAM[15] = 8'hB3;
            RAM[16] = 8'h00;  // Instruction_5__________ADD, R6, R5, R4
            RAM[17] = 8'h42;  
            RAM[18] = 8'h83;  
            RAM[19] = 8'h33;
            RAM[20] = 8'h00;   // Instruction_6____________MAC Instruction
            RAM[21] = 8'h00;  
            RAM[22] = 8'h02;  
            RAM[23] = 8'h7F;
            RAM[24] = 8'h00;   // Instruction_7
            RAM[25] = 8'h84;  
            RAM[26] = 8'h80;  
            RAM[27] = 8'hB3;
            RAM[28] = 8'h00;  // Instruction_8
            RAM[29] = 8'hA5;  
            RAM[30] = 8'h80;  
            RAM[31] = 8'hB3;
//            RAM[32] = 8'h00;  // Instruction_9
//            RAM[33] = 8'h21;  
//            RAM[34] = 8'h80;  
//            RAM[35] = 8'hB3;
//            RAM[36] = 8'h00;  // Instruction_10
//            RAM[37] = 8'h1A;  
//            RAM[38] = 8'h2F;  
//            RAM[39] = 8'h23;
//            RAM[40] = 8'h01;  // Instruction_10
//            RAM[41] = 8'hEA;  
//            RAM[42] = 8'h28;  
//            RAM[43] = 8'h03;   
//            RAM[44] = 8'hAB;  // Instruction_10
//            RAM[45] = 8'hCD;  
//            RAM[46] = 8'hEF;  
//            RAM[47] = 8'h97;         
        end
//    assign address_RAM = address_bus_IR[6:0];
    always @(*)
        inst_mem_bus_IR = {RAM[address_bus_IR[6:0]],RAM[address_bus_IR[6:0]+1],RAM[address_bus_IR[6:0]+2],RAM[address_bus_IR[6:0]+3]};
endmodule
