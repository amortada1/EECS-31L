`timescale 1ns / 1ps

// module definition
module alu_32(A_in, B_in, ALU_Sel, ALU_Out, Carry_Out, Zero, Overflow);

// constant declarations
localparam WIDTH = 32;
localparam MSB = WIDTH - 1;

// define I/O ports
input [MSB:0] A_in;
input [MSB:0] B_in;
input [3:0] ALU_Sel;
output reg [MSB:0] ALU_Out;
output reg Carry_Out;
output Zero;
output reg Overflow;

// internal wires
reg extra_bit; // for signed addition
reg [MSB:0] temp_result; // for finding the carry out of signed addition

// describe ALU behavior
always@ (A_in, B_in, ALU_Sel)
begin
    case (ALU_Sel)
        4'b0000: begin // bitwise AND
                    ALU_Out = A_in & B_in;
                    Overflow = 1'b0;
                    Carry_Out = 1'b0;
                 end
        4'b0001: begin // bitwise OR
                    ALU_Out = A_in | B_in;
                    Overflow = 1'b0;
                    Carry_Out = 1'b0; 
                 end
        4'b0010: begin // signed addition
                    {extra_bit, ALU_Out} = {A_in[MSB], A_in} + {B_in[MSB], B_in}; // perform addition with "extended bit"
                    Overflow = ({extra_bit, ALU_Out[MSB]} == 2'b01) | // case for overflow
                               ({extra_bit, ALU_Out[MSB]} == 2'b10);  // case for underflow
                    {Carry_Out, temp_result} = A_in + B_in; // to find carry out bit
                 end
        4'b0110: begin // signed subtraction
                    {extra_bit, ALU_Out} = {A_in[MSB], A_in} - {B_in[MSB], B_in}; // perform subtraction with "extended bit"
                    Overflow = ({extra_bit, ALU_Out[MSB]} == 2'b01) | // case for overflow
                               ({extra_bit, ALU_Out[MSB]} == 2'b10);  // case for underflow
                    Carry_Out = 1'b0;
                 end
        4'b0111: begin // signed set less than
                    ALU_Out = $signed(A_in) < $signed(B_in);
                    Overflow = 1'b0;
                    Carry_Out = 1'b0;
                 end 
        4'b1100: begin // bitwise NOR
                    ALU_Out = ~(A_in | B_in);
                    Overflow = 1'b0;
                    Carry_Out = 1'b0; 
                 end 
        4'b1111: begin // equal comparison
                    ALU_Out = A_in == B_in;
                    Overflow = 1'b0;
                    Carry_Out = 1'b0;
                 end 
        default: begin // default case is signed addition
                    {extra_bit, ALU_Out} = {A_in[MSB], A_in} + {B_in[MSB], B_in}; // perform addition with "extended bit"
                    Overflow = ({extra_bit, ALU_Out[MSB]} == 2'b01) | // case for overflow
                               ({extra_bit, ALU_Out[MSB]} == 2'b10);  // case for underflow
                    {Carry_Out, temp_result} = A_in + B_in; // to find carry out bit
                 end
    endcase    
end

// set "Zero" output to 1 whenever ALU_Out is 0
assign Zero = (ALU_Out == 32'b0);

endmodule // 32-bit ALU
