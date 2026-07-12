`timescale 1ns / 1ps

// module definition
module FlipFlop(clk, reset, d, q);

// define input and output signals
input clk;
input reset;
input [7:0] d;
output reg [7:0] q;

// define module behavior
always @(posedge clk) // trigger on rising edge
begin
    case (reset)
        1'b0: q <= d;
        1'b1: q <= 8'b0;
    endcase
end

endmodule // FlipFlop
