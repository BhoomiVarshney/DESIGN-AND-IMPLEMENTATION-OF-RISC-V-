`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// module RISC_R_main(clock, final_result, reset);
module RISC_R_main(clock, final_result, reset, address_bus_IR, instruction, reg1_out, reg2_out, alu_partialresult, inter_result, acc_out, address);   
    input clock, reset;
    output [31:0]final_result, reg1_out, reg2_out, alu_partialresult, inter_result, address_bus_IR, instruction;
    output [63:0] acc_out;
    output [20:0] address;
    wire reg_write, mux2_ctrl, mux3_ctrl, is_call, is_branch, is_uformat, is_load, is_store, is_auipc, should_branch;
    wire [4:0]dest_reg, source_reg1, source_reg2, rs1_field, rs2_field;
    wire [31:0]  pc_in;
    wire [6:0] opcode;
    wire [2:0] funct3, sb_kind, mux1_ctrl, load_variant, store_variant;
    wire [31:0] I_immediate, s_immediate, u_immediate, sb_immediate, uj_immediate;
    wire [6:0] funct7;
    wire [31:0] pc_value, pc_in_actual, immediate_final, branch_target, mux2_out, mux3_out, mux4_out, mux5_out, load_data;
    wire [3:0] alu_ctrl;
    wire [63:0]  IF_D_Register;
    wire [196:0] D_E_register; 
    wire [112:0] E_M_register;
    wire [70:0] M_WB_register;
    wire [1:0] operand1_select, operand2_select;
    wire [31:0] mux_second_op, mux_third_op;
    wire DE_register_reset, IFD_register_hold, pc_hold; // Hazard Signals for the load case
// MAC Declarations
    wire is_mac;
    wire [31:0] first_operand, second_operand;
    wire [25:0] mac_IR_reg, MIR_updated;
    wire [63:0] MOR_out, mul_output, MUL_reg_out, adder_out;
    assign inter_result = E_M_register[36:5];
    assign address = mac_IR_reg[24:4]; 
//Stage 1    
PC_incrementer pcinc(address_bus_IR, pc_in); 
pc_mux pcselect(pc_in, E_M_register[36:5], E_M_register[71], E_M_register[73], E_M_register[106], pc_in_actual); 
PC_Register pcreg(clock, reset, pc_hold, pc_in_actual, address_bus_IR); 
Instruction_Memory instmem(reset, address_bus_IR, instruction); 
MAC_RISC_Instruction_Decoder MRID(instruction[6:0], is_mac); 
//Reg 1 
IF_Decode_Register idreg(clock, reset, is_mac, IFD_register_hold, address_bus_IR, instruction, IF_D_Register);
//Stage 2__Decode Stage 
Instruction_decoder instdec(IF_D_Register[31:0], dest_reg, source_reg1, source_reg2, opcode, funct3, funct7);   
Immediate_calculator immcal(dest_reg, source_reg1, source_reg2, funct3, funct7, I_immediate, s_immediate, u_immediate, sb_immediate, uj_immediate);
Register_file regfile(reset, M_WB_register[70], M_WB_register[4:0], source_reg1, source_reg2, final_result, reg1_out, reg2_out);  //Check out write_data signal as it is coming from the final stage
immediate_finder immfind(IF_D_Register[63:32], mux1_ctrl, I_immediate, s_immediate, u_immediate, sb_immediate, uj_immediate, immediate_final, branch_target);    
Controller_main cont(opcode, funct3, funct7, alu_ctrl, mux2_ctrl, mux3_ctrl, reg_write, is_call, is_branch, is_uformat, is_load, is_store, is_auipc, mux1_ctrl, sb_kind, load_variant, store_variant);
//Reg 2
Decode_Exe_register dereg(clock, reset, DE_register_reset, IF_D_Register[11:7], branch_target, immediate_final, reg1_out, reg2_out, IF_D_Register[63:32], alu_ctrl, mux2_ctrl, mux3_ctrl, is_uformat, is_branch, sb_kind, is_load, is_store, is_call, reg_write, is_auipc, load_variant, store_variant, IF_D_Register[19:15], IF_D_Register[24:20], D_E_register);
// Stage 3__Execute Stage
mux_second m2(D_E_register[169], mux_second_op, D_E_register[164:133], mux2_out);
mux_third m3(D_E_register[170], mux_third_op, D_E_register[68:37], mux3_out);
ALU aluaddand(D_E_register[168:165], mux2_out, mux3_out, alu_partialresult);
mux_fourth m4(D_E_register[171], alu_partialresult, D_E_register[68:37], mux4_out);
mux_fifth m5(D_E_register[172], mux4_out, D_E_register[36:5], mux5_out);
comparator_block comp(D_E_register[100:69], D_E_register[132:101], D_E_register[175:173], should_branch);
//Reg 3
Exe_Mem_register exmem(clock, reset, D_E_register[4:0], mux5_out, D_E_register[164:133], D_E_register[176], D_E_register[177], D_E_register[178], D_E_register[179], D_E_register[180], D_E_register[132:101], should_branch, D_E_register[183:181], D_E_register[186:184], E_M_register);
// Stage 4__Memory Access Stage 
Data_memory dtmem(reset, E_M_register[36:5], E_M_register[105:74], load_data, E_M_register[69], E_M_register[70], E_M_register[109:107], E_M_register[112:110]);
// Reg 4
Mem_WB_register mwb(clock, reset, E_M_register[4:0], load_data, E_M_register[68:37], E_M_register[71], E_M_register[72], M_WB_register); 
// Stage 5_Write Back Stage
final_result_mux finmux(M_WB_register[36:5], M_WB_register[68:37], M_WB_register[69], final_result);
// Hazard Mitigation
Forwarding_Unit FU(D_E_register[191:187], D_E_register[196:192], E_M_register[4:0], M_WB_register[4:0], operand1_select, operand2_select, E_M_register[72], M_WB_register[70]);
Hazard_detection_loadcase HDL(D_E_register[176], D_E_register[4:0], IF_D_Register[19:15], IF_D_Register[24:20], DE_register_reset, IFD_register_hold, pc_hold);
Hazard_Operand1_Select HM1(operand1_select, D_E_register[100:69], E_M_register[36:5], M_WB_register[36:5], mux_second_op);
Hazard_Operand2_Select HM2(operand2_select, D_E_register[132:101], E_M_register[36:5], M_WB_register[36:5], mux_third_op);
// MAC Unit for MAC Instructions
MAC_Instruction_Register MIR(clock, reset, is_mac, instruction[31:7], mac_IR_reg, MIR_updated);
MAC_IR_updated MIU(mac_IR_reg[24:4], mac_IR_reg[3:0], MIR_updated, is_mac);
MAC_Instruction_Memory MIM(reset, mac_IR_reg[24:4], mac_IR_reg[25], first_operand, second_operand);
MAC_operand_register MOR(clock, reset, first_operand, second_operand, MOR_out);
assign mul_output = first_operand*second_operand;
MUL_Register MR(clock, reset, mul_output, MUL_reg_out);
ADDER add(acc_out, MUL_reg_out, adder_out);
Accumulator acc(clock, reset, adder_out, acc_out);
endmodule
