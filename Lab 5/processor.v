`timescale 1ns / 1ps

module processor(
    input clk, reset,
    output [31:0] Result
);

// internal wire declarations
wire MemtoReg;
wire MemWrite;
wire MemRead;
wire ALUSrc;
wire RegWrite;
wire [6:0] Opcode;
wire [1:0] ALUOp;
wire [2:0] Funct3;
wire [6:0] Funct7;
wire [3:0] Operation;

// instantiate and connect each module
Controller ctrl(
    .Opcode(Opcode),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUOp(ALUOp)
);

ALUController alu_ctrl(
    .ALUOp(ALUOp),
    .Funct3(Funct3),
    .Funct7(Funct7),
    .Operation(Operation)
);

data_path dp(
    .clk(clk),
    .reset(reset),
    .reg_write(RegWrite),
    .mem2reg(MemtoReg),
    .alu_src(ALUSrc),
    .mem_write(MemWrite),
    .mem_read(MemRead),
    .alu_cc(Operation),
    .opcode(Opcode),
    .funct3(Funct3),
    .funct7(Funct7),
    .alu_result(Result)
);

endmodule
