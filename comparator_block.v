`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module comparator_block(operand1, operand2, sb_kind, should_branch);

    input [31:0] operand1, operand2;
    input [2:0] sb_kind;
    output reg should_branch;
    
    always @(*)
        begin
            case (sb_kind)
                3'b001 : should_branch = (operand1==operand2 ? 1 : 0);
                3'b010 : should_branch = (operand1==operand2 ? 0 : 1);
                3'b011 : should_branch = (operand1 >= operand2 ? 1 : 0);
                3'b100 : should_branch = (operand1 < operand2 ? 1 : 0); 
                default : should_branch = 0;
            endcase  
        end 
endmodule
