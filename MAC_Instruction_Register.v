`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module MAC_Instruction_Register(clock, reset, is_mac, instruction, mac_IR_reg, MIR_updated);
    
    input clock, reset, is_mac;
    input [24:0] instruction;
    input [25:0] MIR_updated;
    output reg [25:0] mac_IR_reg;
    
    always @(posedge reset, posedge clock)
        begin
            if (reset == 1)
                mac_IR_reg <= 0;
            else if (is_mac == 1)
                mac_IR_reg <= {1'b1, instruction};
            else 
                mac_IR_reg <= MIR_updated;
        end
endmodule