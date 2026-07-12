`timescale 1ns / 1ps

// module definition
module Mux_4_To_1(
    input [1:0] S,
    input D1,
    input D2,
    input D3,
    input D4,
    output Y    
);

// mux4:1 behavior definition
// following statement acts like a switch statement
// if S = 00, Y = D1
// if S = 01, Y = D2
// if S = 10, Y = D3
// if S = 11, Y = D4
assign Y = (S == 2'b00) ? D1 :
           (S == 2'b01) ? D2 :
           (S == 2'b10) ? D3 :
           D4;

endmodule
