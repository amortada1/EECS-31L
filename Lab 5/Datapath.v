////   Data Path /////
module data_path #(
    parameter PC_W = 8,       // Program Counter
    parameter INS_W = 32,     // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32,    // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4    // ALU Control Code Width
 )(
    input                  clk ,    // CLK in datapath figure
    input                  reset,   // Reset in datapath figure      
    input                  reg_write,   // RegWrite in datapath figure
    input                  mem2reg,     // MemtoReg in datapath figure
    input                  alu_src,     // ALUSrc in datapath figure 
    input                  mem_write,   // MemWrite in datapath figure  
    input                  mem_read,    // MemRead in datapath figure          
    input  [ALU_CC_W-1:0]  alu_cc,      // ALUCC in datapath figure
    output          [6:0]  opcode,      // opcode in dataptah figure
    output          [6:0]  funct7,      // Funct7 in datapath figure
    output          [2:0]  funct3,      // Funct3 in datapath figure
    output   [DATA_W-1:0]  alu_result   // Datapath_Result in datapath figure
 );

// Write your code here
// define internal wires
wire [PC_W-1:0] PC;
wire [PC_W-1:0] PCPlus4 = PC + 4;
wire [INS_W-1:0] Instruction;
wire [DATA_W-1:0] WriteBack_Data;
wire [31:0] Reg1;
wire [31:0] Reg2;
wire [31:0] SrcB;
wire [31:0] ExtImm;
wire [31:0] ALU_Result;
wire [31:0] DataMem_read;
wire [RF_ADDRESS-1:0] rd_rg_wrt_wire;
wire [RF_ADDRESS-1:0] rd_rg_addr_wire1;
wire [RF_ADDRESS-1:0] rd_rg_addr_wire2;

assign rd_rg_wrt_wire = Instruction[11:7];
assign rd_rg_addr_wire1 = Instruction[19:15];
assign rd_rg_addr_wire2 = Instruction[24:20];

// instantiate inner modules and connect them to wires
FlipFlop ff(.clk(clk), .reset(reset), .d(PCPlus4), .q(PC));

InstMem inst_mem(.addr(PC), .instruction(Instruction));

RegFile reg_file(
    .clk(clk), .reset(reset), .rg_wrt_en(reg_write),
    .rg_wrt_addr(rd_rg_wrt_wire),
    .rg_rd_addr1(rd_rg_addr_wire1),
    .rg_rd_addr2(rd_rg_addr_wire2),
    .rg_wrt_data(WriteBack_Data),
    .rg_rd_data1(Reg1),
    .rg_rd_data2(Reg2) 
);

ImmGen imm_gen(.InstCode(Instruction[31:0]), .ImmOut(ExtImm));

MUX21 mux1(.D1(Reg2), .D2(ExtImm), .S(alu_src), .Y(SrcB));

alu_32 alu(
    .A_in(Reg1),
    .B_in(SrcB),
    .ALU_Sel(alu_cc),
    .ALU_Out(ALU_Result),
    .Carry_Out(), .Zero(), .Overflow()
);

DataMem data_mem(
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .addr(ALU_Result[DM_ADDRESS-1:0]),
    .write_data(Reg2),
    .read_data(DataMem_read)
);

MUX21 mux2(.D1(ALU_Result), .D2(DataMem_read), .S(mem2reg), .Y(WriteBack_Data));

// assign internal wires to module outputs
assign opcode = Instruction[6:0];
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];
assign alu_result = ALU_Result;

endmodule
