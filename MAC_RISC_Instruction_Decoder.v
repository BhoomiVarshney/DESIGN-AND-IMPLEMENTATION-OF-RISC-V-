`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module MAC_RISC_Instruction_Decoder(opcode, is_mac);
    
    input [6:0] opcode;
    output reg is_mac;
    
    always @(*)
        begin
            if (opcode == 7'b1111111)
                is_mac = 1;
            else 
                is_mac = 0;
        end
endmodule
