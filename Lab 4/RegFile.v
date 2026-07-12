`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: 
// Module Name: RegFile
// 
//////////////////////////////////////////////////////////////////////////////////

module RegFile(
  input clk, reset, rg_wrt_en,
  input [4:0] rg_wrt_addr, 
  input [4:0] rg_rd_addr1,
  input [4:0] rg_rd_addr2, 
  input [31:0] rg_wrt_data,
  output wire [31:0] rg_rd_data1,
  output wire [31:0] rg_rd_data2
);

// Write your code
// internal storage for register file
reg [31:0] register_file [31:0]; // 32 bits wide, 32 bits long
integer i;

// reset (asynchronous)
always @(reset) begin
    if (reset) begin
        for (i = 0; i < 32; i = i + 1) begin
            register_file[i] = 32'h00000000;
        end
    end
end

// read from register file (asynchronous)
assign rg_rd_data1 = register_file[rg_rd_addr1];
assign rg_rd_data2 = register_file[rg_rd_addr2]; 

// write to register file (synchronous)
always @(posedge clk) begin
    if (reset == 1'b0 && rg_wrt_en == 1'b1) begin
        register_file[rg_wrt_addr] <= rg_wrt_data;
    end
end

endmodule


