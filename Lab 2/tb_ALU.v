`timescale 1ns / 1ps

module alu_32_tb();

localparam WIDTH = 32;
localparam MSB = WIDTH - 1;

// define input and output ports
reg [MSB:0] A_in_tb;
reg [MSB:0] B_in_tb;
reg [3:0] ALU_Sel_tb;
wire [MSB:0] ALU_Out_tb;
wire Carry_Out_tb;
wire Zero_tb;
wire Overflow_tb;

// port mapping
alu_32 instant
(
    .A_in(A_in_tb),
    .B_in(B_in_tb),
    .ALU_Sel(ALU_Sel_tb),
    .ALU_Out(ALU_Out_tb),
    .Carry_Out(Carry_Out_tb),
    .Zero(Zero_tb),
    .Overflow(Overflow_tb)
);

// test samples
initial
begin
    // test 1 (AND)
    A_in_tb = 32'h086a0c31;
    B_in_tb = 32'hd785f148;
    ALU_Sel_tb = 4'b0000;
    #20;
    
    // test 2 (OR)
    A_in_tb = 32'h086a0c31;
    B_in_tb = 32'h10073fd4;
    ALU_Sel_tb = 4'b0001;
    #20;
    
    // test 3 (add)
    A_in_tb = 32'ha86a0c31;
    B_in_tb = 32'h90073fd4;
    ALU_Sel_tb = 4'b0010;
    #20;
    
    // test 4 (subtract)
    A_in_tb = 32'ha86a0c31;
    B_in_tb = 32'h90073fd4;
    ALU_Sel_tb = 4'b0110;
    #20;
    
    // test 5 (set less than)
    A_in_tb = 32'ha86a0c31;
    B_in_tb = 32'h90073fd4;
    ALU_Sel_tb = 4'b0111;
    #20;
    
    // test 6 (NOR)
    A_in_tb = 32'ha86a0c31;
    B_in_tb = 32'h90073fd4;
    ALU_Sel_tb = 4'b1100;
    #20;
    
    // test 7 (equal, true)
    A_in_tb = 32'ha86a0c31;
    B_in_tb = 32'ha86a0c31;
    ALU_Sel_tb = 4'b1111;
    #20;
    
    // test 8 (equal, false)
    A_in_tb = 32'ha86a0c31;
    B_in_tb = 32'h10073fd4;
    ALU_Sel_tb = 4'b1111;
    #20;
end

endmodule
