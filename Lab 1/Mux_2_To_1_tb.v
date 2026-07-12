`timescale 1ns / 1ps

module Mux_2_To_1_tb();

// define input and output ports
reg S_tb;
reg D1_tb;
reg D2_tb;
wire Y_tb;

// port mapping
Mux_2_To_1 instant
    (
     .S(S_tb),
     .D1(D1_tb),
     .D2(D2_tb),
     .Y(Y_tb)
    );

// test samples
initial
    begin
        // D1 = 0, D2 = 1, S = 0
        D1_tb = 1'b0;
        D2_tb = 1'b1;
        S_tb = 1'b0;
        #20;
        
        // D1 = 0, D2 = 1, S = 1
        D1_tb = 1'b0;
        D2_tb = 1'b1;
        S_tb = 1'b1;
        #20;
    end

endmodule
