`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module MAC_Instruction_Memory(reset, address, stop_signal, first_operand, second_operand);
    
    input reset, stop_signal;
    input [20:0] address;
    output reg [31:0] first_operand, second_operand;
    
    reg [7:0] RAM [0:127];
    integer i;
    
    always @(posedge reset) 
        begin
            for (i=0; i<128; i = i+1)
                RAM[i] = 0;
            RAM[0] = 8'h00;  // Instruction_1_________ADD R1, R2, R3
            RAM[1] = 8'h00;  
            RAM[2] = 8'h00;  
            RAM[3] = 8'h00;  
            RAM[4] = 8'h00;  // Instruction_2__________ADD R4, R1, R3
            RAM[5] = 8'h00;  
            RAM[6] = 8'h00;  
            RAM[7] = 8'h00;
            RAM[8] = 8'h00;   // Instruction_3_________Ld R4, R0, 30
            RAM[9] = 8'h00;  
            RAM[10] = 8'h00;  
            RAM[11] = 8'h01;
            RAM[12] = 8'h00;  // Instruction_4__________ADD, R5, R4, R1
            RAM[13] = 8'h00;  
            RAM[14] = 8'h00;  
            RAM[15] = 8'h02;
            RAM[16] = 8'h00;  // Instruction_5__________ADD, R6, R5, R4
            RAM[17] = 8'h00;  
            RAM[18] = 8'h00;  
            RAM[19] = 8'h03;
            RAM[20] = 8'h00;   // Instruction_6________MAC
            RAM[21] = 8'h00;  
            RAM[22] = 8'h00;  
            RAM[23] = 8'h04;
            RAM[24] = 8'h00;   // Instruction_7
            RAM[25] = 8'h00;  
            RAM[26] = 8'h00;  
            RAM[27] = 8'h05;
            RAM[28] = 8'h00;  // Instruction_8
            RAM[29] = 8'h00;  
            RAM[30] = 8'h00;  
            RAM[31] = 8'h06;
            RAM[32] = 8'h00;  
            RAM[33] = 8'h00;  
            RAM[34] = 8'h00;
            RAM[35] = 8'h07;   // Instruction_6________MAC
            RAM[36] = 8'h00;  
            RAM[37] = 8'h00;  
            RAM[38] = 8'h00;
            RAM[39] = 8'h08;   // Instruction_7
            RAM[40] = 8'h00;  
            RAM[41] = 8'h00;  
            RAM[42] = 8'h00;
            RAM[43] = 8'h0A;  // Instruction_8
//            RAM[44] = 8'h00;  
//            RAM[45] = 8'h00;  
//            RAM[46] = 8'h00;
        end
    
    always @(address)
        begin
            if (stop_signal == 1) 
            begin
                first_operand = {RAM[address[6:0]],RAM[address[6:0]+1],RAM[address[6:0]+2],RAM[address[6:0]+3]};
                second_operand = {RAM[address[6:0]+4],RAM[address[6:0]+5],RAM[address[6:0]+6],RAM[address[6:0]+7]};
            end 
            else 
            begin
                first_operand = 0;
                second_operand = 0;
            end
        end
endmodule