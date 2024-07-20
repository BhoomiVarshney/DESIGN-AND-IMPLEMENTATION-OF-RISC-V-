`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Register_file(reset, reg_write, dest_reg, source_reg1, source_reg2, write_data, reg1_out, reg2_out);
    input reg_write, reset;
    input [4:0] dest_reg, source_reg1, source_reg2;
    input [31:0] write_data;
    output reg [31:0] reg1_out, reg2_out;
    
    reg [31:0] REG [0:31];
    integer i;
    always @(posedge reset) 
        begin
            reg1_out = 0;
            reg2_out = 0;
            for (i=0; i<32; i=i+1)
                begin 
                    REG[i] = i;
                end
        end
    always @(dest_reg, source_reg1, source_reg2)
        begin
            reg1_out <= REG[source_reg1];
            reg2_out <= REG[source_reg2];
        end 
    always @(write_data)
        if (reg_write==1)
            REG[dest_reg] <= write_data;
endmodule
