`timescale 1ns / 1ps

module ALUController(
    ALUOp, Funct7, Funct3, Operation
);

// input/output signal definitions
input [1:0] ALUOp;
input [2:0] Funct3;
input [6:0] Funct7;
output reg [3:0] Operation; 

// ALU controller module behavior
always @(*) begin
    casex (Funct7)
        7'b0000000:
        begin
            Operation <= ((Funct3 == 3'b111) && (ALUOp == 2'b10)) ? 4'b0000 :
                         ((Funct3 == 3'b110) && (ALUOp == 2'b10)) ? 4'b0001 :
                         ((Funct3 == 3'b100) && (ALUOp == 2'b10)) ? 4'b1100 :
                         ((Funct3 == 3'b010) && (ALUOp == 2'b10)) ? 4'b0111 :
                         4'b0010;
        end
        7'b0100000:
        begin
            if ((Funct3 == 3'b000) && (ALUOp == 2'b10))
                Operation <= 4'b0110;
        end
        7'bxxxxxxx:
        begin
            Operation <= ((Funct3 == 3'b111) && (ALUOp == 2'b00)) ? 4'b0000 :
                         ((Funct3 == 3'b110) && (ALUOp == 2'b00)) ? 4'b0001 :
                         ((Funct3 == 3'b100) && (ALUOp == 2'b00)) ? 4'b1100 :
                         ((Funct3 == 3'b010) && (ALUOp == 2'b00)) ? 4'b0111 :
                         ((Funct3 == 3'b000) && (ALUOp == 2'b00)) ? 4'b0010 :
                         ((Funct3 == 3'b010) && (ALUOp == 2'b01)) ? 4'b0010 :
                         4'b0010;
        end
    endcase
end

endmodule
