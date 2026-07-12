`timescale 1ns / 1ps

module FA_tb();

// define input and output ports
reg A_tb;
reg B_tb;
reg Cin_tb;
wire Sum_tb;
wire Cout_tb;

// port mapping
FA instant
   (
    .A(A_tb),
    .B(B_tb),
    .Cin(Cin_tb),
    .Sum(Sum_tb),
    .Cout(Cout_tb)
   );

// test samples
initial
    begin
        // A = 0, B = 1, Cin = 0;
        A_tb = 1'b0;
        B_tb = 1'b1;
        Cin_tb = 1'b0;
        #20;
        
        // A = 1, B = 1, Cin = 0;
        A_tb = 1'b1;
        B_tb = 1'b1;
        Cin_tb = 1'b0;
        #20;
        
        // A = 1, B = 1, Cin = 1;
        A_tb = 1'b1;
        B_tb = 1'b1;
        Cin_tb = 1'b1;
        #20;   
end

endmodule
