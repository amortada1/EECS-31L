`timescale 1ns / 1ps

// module and input/output definitions
module FA4(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
);

// definition for internal signals
wire [3:0] Carry;

// full adder behavior definition
// sum0, carry0
assign Sum[0] = (A[0] ^ B[0]) ^ Cin;
assign Carry[0] = (Cin & (A[0] ^ B[0])) | (A[0] & B[0]);

// sum1, carry1
assign Sum[1] = (A[1] ^ B[1]) ^ Carry[0];
assign Carry[1] = (Carry[0] & (A[1] ^ B[1])) | (A[1] & B[1]);

// sum2, carry2
assign Sum[2] = (A[2] ^ B[2]) ^ Carry[1];
assign Carry[2] = (Carry[1] & (A[2] ^ B[2])) | (A[2] & B[2]);

// sum3, carry3
assign Sum[3] = (A[3] ^ B[3]) ^ Carry[2];
assign Carry[3] = (Carry[2] & (A[3] ^ B[3])) | (A[3] & B[3]);

// carry out
assign Cout = Carry[3];

endmodule
