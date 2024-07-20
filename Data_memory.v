`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Data_memory(reset, mem_address, operand2, load_data, is_ld, is_st, load_variant, store_variant);
    input reset, is_ld, is_st;
    input [2:0] load_variant, store_variant;
    output reg [31:0] load_data;
    input [31:0] mem_address, operand2;
    
  //  reg [7:0] temp_data; 
    reg [7:0] Data_RAM [0:127];
        integer i;
    
    always @(posedge reset) 
        for (i=0; i<128; i = i+1)
                Data_RAM[i] = i;
        
    always @(mem_address, is_ld, is_st)
        begin
            if (is_ld == 1 & is_st==0)
            begin
                case (load_variant)
                    3'b000 : load_data = {{24{Data_RAM[mem_address[6:0]][7]}},Data_RAM[mem_address[6:0]]}; 
                    3'b001 : load_data = {{16{Data_RAM[mem_address[6:0]][7]}},Data_RAM[mem_address[6:0]], Data_RAM[mem_address[6:0]+1]};
                    3'b010 : load_data = {Data_RAM[mem_address[6:0]],Data_RAM[mem_address[6:0]+1],Data_RAM[mem_address[6:0]+2],Data_RAM[mem_address[6:0]+3]};
                    3'b100 : load_data = {{16{1'b0}},Data_RAM[mem_address[6:0]], Data_RAM[mem_address[6:0]+1]};
                    3'b101 : load_data = {{24{1'b0}},Data_RAM[mem_address[6:0]]};
                    default : load_data = {Data_RAM[mem_address[6:0]],Data_RAM[mem_address[6:0]+1],Data_RAM[mem_address[6:0]+2],Data_RAM[mem_address[6:0]+3]};
                endcase
            end
            else if ((is_ld==0) & (is_st==1))
                begin
                case (store_variant)
                    3'b000 : Data_RAM[mem_address] = operand2[7:0];
                    3'b001 : begin
                                Data_RAM[mem_address] = operand2[15:8];
                                Data_RAM[mem_address+1] = operand2[7:0];
                             end
                    3'b010 : begin 
                                Data_RAM[mem_address] = operand2[31:24];
                                Data_RAM[mem_address+1] = operand2[23:16];
                                Data_RAM[mem_address+2] = operand2[15:8];
                                Data_RAM[mem_address+3] = operand2[7:0];
                             end
                    default : begin 
                                  Data_RAM[mem_address] = operand2[31:24];
                                  Data_RAM[mem_address+1] = operand2[23:16];
                                  Data_RAM[mem_address+2] = operand2[15:8];
                                  Data_RAM[mem_address+3] = operand2[7:0]; 
                              end
                endcase 
                end
            else load_data = mem_address;
        end
endmodule
