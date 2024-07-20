`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Controller_main(opcode, funct3, funct7, alu_ctrl, mux2_ctrl, mux3_ctrl, reg_write, is_call, is_branch, is_uformat, is_load, is_store, is_auipc, mux1_ctrl, sb_kind, load_variant, store_variant);
    input [6:0] opcode;
    input [2:0] funct3;
    input [6:0] funct7;
    output reg [3:0] alu_ctrl;
    output reg mux2_ctrl, mux3_ctrl, reg_write, is_call, is_branch, is_uformat, is_load, is_store, is_auipc;
    output reg [2:0] mux1_ctrl, sb_kind, load_variant, store_variant;
                             
    always @(opcode)
        begin
            case (opcode)
                7'b0110011 : begin               // R-type instructions
                             mux1_ctrl = 3'b111;
                             mux2_ctrl = 1'b1;
                             mux3_ctrl = 1'b1;
                             is_branch = 1'b0;
                             is_uformat = 1'b0;
                             sb_kind = 3'b111;   // No branch is taken
                             is_load = 1'b0;
                             is_store = 1'b0;
                             is_call = 1'b0;
                             reg_write = 1'b1;
                             is_auipc = 1'b0;
                             load_variant = 3'b010;
                             store_variant = 3'b010;
                            case (funct3)
                                3'b000 : begin 
                                            if (funct7 == 7'b0000000)
                                                alu_ctrl = 4'b0000;  // ALU performing add
                                            else
                                                alu_ctrl = 4'b0001;  // ALU performing sub
                                         end
                                3'b001 : alu_ctrl = 4'b0010;  // ALU performing shift Left Logical
                                3'b010 : alu_ctrl = 4'b0011;  // ALU performing set less than
                                3'b011 : alu_ctrl = 4'b0100;  // ALU performing sltu
                                3'b101 : if (funct7 == 7'b0000000)
                                            alu_ctrl = 4'b0101;  // ALU performing shift right Logical
                                         else 
                                            alu_ctrl = 4'b0110;  // ALU performing shift right arithmetic
                                3'b100 : alu_ctrl = 4'b0111;  // ALU performing xor
                                3'b110 : alu_ctrl = 4'b1000;  // ALU performing or
                                3'b111 : alu_ctrl = 4'b1001;  // ALU performing and
                             endcase
                             end
                7'b0010011 : begin               // I-type_Arithmetic and Logical instructions
                             mux1_ctrl = 3'b000;
                             mux2_ctrl = 1'b1;
                             mux3_ctrl = 1'b0;
                             is_branch = 1'b0;
                             is_uformat = 1'b0;
                             sb_kind = 3'b111;   // No conditional_branch is taken
                             is_load = 1'b0;
                             is_store = 1'b0;
                             is_call = 1'b0;
                             reg_write = 1'b1;
                             is_auipc = 1'b0;
                             load_variant = 3'b010;
                             store_variant = 3'b010;
                            case (funct3)
                                3'b000 : alu_ctrl = 4'b0000;
                                3'b001 : alu_ctrl = 4'b0010;
                                3'b010 : alu_ctrl = 4'b0011;
                                3'b011 : alu_ctrl = 4'b0100;
                                3'b101 : if (funct7 == 7'b0000000)
                                            alu_ctrl = 4'b0101;
                                         else
                                            alu_ctrl = 4'b0110;
                                3'b110 : alu_ctrl = 4'b1000;
                                3'b111 : alu_ctrl = 4'b1001;
                            endcase
                            end
                7'b0000011 : begin              // I_Type_Load Instructions
                             mux1_ctrl = 3'b000;
                             mux2_ctrl = 1'b1;
                             mux3_ctrl = 1'b0;
                             is_branch = 1'b0;
                             is_uformat = 1'b0;
                             sb_kind = 3'b111;   // No conditional_branch is taken
                             is_load = 1'b1;
                             is_store = 1'b0;
                             is_call = 1'b0;
                             reg_write = 1'b1;
                             alu_ctrl = 4'b0000;
                             is_auipc = 1'b0;
                             store_variant = 3'b010;
                             case (funct3)
                                3'b000 : load_variant = 3'b000;
                                3'b001 : load_variant = 3'b001;
                                3'b010 : load_variant = 3'b010;
                                3'b100 : load_variant = 3'b100;
                                3'b101 : load_variant = 3'b101;
                                default : load_variant = 3'b010;
                             endcase
                             end
                7'b0100011 : begin                  // Store_S_Type Instructions
                             mux1_ctrl = 3'b001;
                             mux2_ctrl = 1'b1;
                             mux3_ctrl = 1'b0;
                             is_branch = 1'b0;
                             is_uformat = 1'b0;
                             sb_kind = 3'b111;   // No conditional_branch is taken
                             is_load = 1'b0;
                             is_store = 1'b1;
                             is_call = 1'b0;
                             reg_write = 1'b0;
                             alu_ctrl = 4'b0000;
                             is_auipc = 1'b0;
                             load_variant = 3'b010;
                             case (funct3)
                                3'b000 : store_variant = 3'b000;
                                3'b001 : store_variant = 3'b001;
                                3'b010 : store_variant = 3'b010;
                                default : store_variant = 3'b010;
                             endcase 
                             end
                7'b0110111 : begin                  // U Type_LUI
                             mux1_ctrl = 3'b010;
                             mux2_ctrl = 1'b1;      // These control signal doesnot matter
                             mux3_ctrl = 1'b1;      // These control signal doesnot matter
                             is_branch = 1'b0;
                             is_uformat = 1'b1;
                             sb_kind = 3'b111;   // No conditional_branch is taken
                             is_load = 1'b0;
                             is_store = 1'b0;
                             is_call = 1'b0;
                             reg_write = 1'b1;
                             alu_ctrl = 4'b0000;   // These control signal doesnot matter
                             is_auipc = 1'b0;
                             load_variant = 3'b010;
                             store_variant = 3'b010;
                             end
                7'b0010111 : begin                  // U Type_AUIPC
                             mux1_ctrl = 3'b010;
                             mux2_ctrl = 1'b0;      
                             mux3_ctrl = 1'b0;      
                             is_branch = 1'b0;
                             is_uformat = 1'b0;
                             sb_kind = 3'b111;   // No conditional_branch is taken
                             is_load = 1'b0;
                             is_store = 1'b0;
                             is_call = 1'b0;
                             reg_write = 1'b0;
                             alu_ctrl = 4'b0000;
                             is_auipc = 1'b1;
                             load_variant = 3'b010;
                             store_variant = 3'b010;
                             end
                7'b1100011 : begin                  // SB Type instructions
                             mux1_ctrl = 3'b011;
                             mux2_ctrl = 1'b0;      // These control signal doesnot matter
                             mux3_ctrl = 1'b0;      // These control signal doesnot matter
                             is_branch = 1'b1;      
                             is_uformat = 1'b0;
                             is_load = 1'b0;
                             is_store = 1'b0;
                             is_call = 1'b0;
                             reg_write = 1'b0;
                             alu_ctrl = 4'b0000;
                             is_auipc = 1'b0;
                             load_variant = 3'b010;
                             store_variant = 3'b010;
                            case (funct3)
                                3'b000 : sb_kind = 3'b001;  // BEQ -- Check if equal
                                3'b001 : sb_kind = 3'b010;  // BNE -- Check if not-equal
                                3'b101 : sb_kind = 3'b011;  // BGE -- Check if greater or equal
                                3'b100 : sb_kind = 3'b100;  // BLT -- Check if less than
                                3'b110 : sb_kind = 3'b101;  // BLT -- Check if less than unsigned
                                3'b111 : sb_kind = 3'b110;  // BLT -- Check if greater than unsigned
                                default : sb_kind = 3'b111;
                            endcase
                            end
                7'b1101000 : begin                  // UJ Type -- jal
                             mux1_ctrl = 3'b100;
                             mux2_ctrl = 1'b0;      
                             mux3_ctrl = 1'b0;      
                             is_branch = 1'b0;
                             is_uformat = 1'b0;
                             sb_kind = 3'b111;   // No conditional_branch is taken
                             is_load = 1'b0;
                             is_store = 1'b0;
                             is_call = 1'b1;
                             reg_write = 1'b1;
                             alu_ctrl = 4'b0000;
                             is_auipc = 1'b0;
                             load_variant = 3'b010;
                             store_variant = 3'b010;
                             end
                7'b1100111 : begin              // UJ Type -- jalr
                             mux1_ctrl = 3'b100;
                             mux2_ctrl = 1'b1;      
                             mux3_ctrl = 1'b0;      
                             is_branch = 1'b0;
                             is_uformat = 1'b0;
                             sb_kind = 3'b111;   // No conditional_branch is taken
                             is_load = 1'b0;
                             is_store = 1'b0;
                             is_call = 1'b1;
                             reg_write = 1'b1;
                             alu_ctrl = 4'b0000;
                             is_auipc = 1'b0;
                             load_variant = 3'b010;
                             store_variant = 3'b010;
                             end
                default : begin              
                             mux1_ctrl = 3'b111;
                             mux2_ctrl = 1'b1;      
                             mux3_ctrl = 1'b0;      
                             is_branch = 1'b0;
                             is_uformat = 1'b1;
                             sb_kind = 3'b111;   // No conditional_branch is taken
                             is_load = 1'b0;
                             is_store = 1'b0;
                             is_call = 1'b0;
                             reg_write = 1'b0;
                             alu_ctrl = 4'b0000;
                             is_auipc = 1'b0;
                             load_variant = 3'b010;
                             store_variant = 3'b010;
                             end
                endcase         
        end
endmodule
