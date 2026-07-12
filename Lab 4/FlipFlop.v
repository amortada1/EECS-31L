`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FlipFlop
//////////////////////////////////////////////////////////////////////////////////

// Module definition
module FlipFlop(
   input  clk , reset,
   input  [7:0] d,
   output reg [7:0] q
);
 
// Write your code
always @(posedge clk) // trigger on rising edge
begin
    case (reset)
        1'b0: q <= d;
        1'b1: q <= 8'b0;
    endcase
end

endmodule 




