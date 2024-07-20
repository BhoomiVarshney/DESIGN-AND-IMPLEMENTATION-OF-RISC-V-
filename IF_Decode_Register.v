`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module IF_Decode_Register(clock, reset, is_mac, IFD_register_hold, address_bus_IR, inst_mem_bus_IR, IF_D_Register);
    
    input clock, reset, IFD_register_hold, is_mac;
    input [31:0] address_bus_IR, inst_mem_bus_IR;
    output reg [63:0] IF_D_Register;
    
    always @(posedge reset, posedge clock)
        begin
            if ((reset == 1) || (is_mac == 1))
                IF_D_Register <= 64'h0000000000000000;
            else if (IFD_register_hold == 0)
                IF_D_Register <= {address_bus_IR, inst_mem_bus_IR};// storing address and instruction also
            else 
                IF_D_Register <= IF_D_Register;
        end

endmodule