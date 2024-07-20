`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Hazard_detection_loadcase(is_load, load_rd_field, IF_D_rs1field, ID_D_rs2field, DE_register_reset, IFD_register_hold, pc_hold);
    input is_load;
    input [4:0] load_rd_field, IF_D_rs1field, ID_D_rs2field;
    output reg DE_register_reset, IFD_register_hold, pc_hold; 
    
    always @(*)
        begin
            if ((is_load ==1) & ((load_rd_field == IF_D_rs1field) || (load_rd_field == IF_D_rs1field)))
                begin
                    pc_hold = 1;
                    DE_register_reset = 1;
                    IFD_register_hold = 1;
                end  
            else
                begin
                    pc_hold = 0;
                    DE_register_reset = 0;
                    IFD_register_hold = 0;
                end   
        end
endmodule
