`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/// data memory
//////////////////////////////////////////////////////////////////////////////////

module DataMem(MemRead, MemWrite, addr, write_data, read_data);

// Define I/O ports
input MemRead;
input MemWrite;
input [8:0] addr;
input [31:0] write_data;
output reg [31:0] read_data;

// Describe DataMem behavior 
reg [31:0] memory [127:0]; // 128x32 internal memory

always @(*)
begin
    if (MemRead) read_data = memory[addr >> 2];
    if (MemWrite) memory[addr >> 2] = write_data; 
end

endmodule
     
