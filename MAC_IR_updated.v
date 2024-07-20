`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module MAC_IR_updated(address, count, MIR_updated, is_mac);
    input is_mac;
    input [20:0] address;
    input [3:0] count;
    output reg [25:0] MIR_updated;
    reg [20:0] temp1;
    reg [3:0] temp2;
    
    always @(*)
        begin
            if (count == 0)
                MIR_updated = 0;
            else 
            begin
                temp1 = address+8;
                temp2 = count-1;
                MIR_updated = {1'b1, temp1, temp2};
            end
        end
endmodule
