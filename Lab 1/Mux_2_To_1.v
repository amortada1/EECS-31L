`timescale 1ns / 1ps

// module definition
module Mux_2_To_1(
    input S,
    input D1,
    input D2,
    output Y
);

// mux2:1 behavior definition
// if S = 0, Y = D1
// if S = 1, Y = D2
assign Y = (S ? D2 : D1);

endmodule
