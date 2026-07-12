`timescale 1ns / 1ps

module FA(
    input A, B, Cin,
    output Sum, Cout
);

// define full adder behavior
assign Sum = A ^ B ^ Cin;
assign Cout = (A & B) | (A & Cin) | (B & Cin);

endmodule
