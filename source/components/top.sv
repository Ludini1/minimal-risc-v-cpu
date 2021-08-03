import common_pkg::*;

module top (
    clk_200M,
    rst,
    debug
);

//IO
input   logic           clk_200M;
input   logic           rst;
output  logic [15:0]    debug;


// Clock Divider
logic clk;

// Control lines
logic [1:0] ctrl_ALU_op;
logic       ctrl_ALU_src;
logic       ctrl_reg_w;
logic       ctrl_mem_w;
logic       ctrl_mem_r;
logic       ctrl_mem_to_reg;
logic       ctrl_branch;

// Instruction memory
logic [INSTRUCTION_WIDTH - 1 : 0] instruction;
logic [INSTRUCTION_MEMORY_ADDRESS_WIDTH - 1 : 0] instruction_address;

// Register file outputs
logic [RISC_V_DATA_WIDTH - 1 : 0] reg_read_data_0;
logic [RISC_V_DATA_WIDTH - 1 : 0] reg_read_data_1;

// Immediate generator
logic signed [RISC_V_DATA_WIDTH - 1 : 0] offset;

// ALU
ALU_ctrl_t  ALU_ctrl;
logic [RISC_V_DATA_WIDTH - 1 : 0]   ALU_data_out;
logic                               ALU_zero_flag;

// Data Memory
logic [RISC_V_DATA_WIDTH - 1 : 0] mem_read_data;


// Modules
clock_divider clock_divider(
    .clk_in(clk_200M),
    .rst(rst),
    .clk_out(clk));


control_unit control_unit(
    .opcode(opcode_t'(instruction[6:0])),
    .ctrl_ALU_op(ctrl_ALU_op),
    .ctrl_ALU_src(ctrl_ALU_src),
    .ctrl_reg_w(ctrl_reg_w),
    .ctrl_mem_w(ctrl_mem_w),
    .ctrl_mem_r(ctrl_mem_r),
    .ctrl_mem_to_reg(ctrl_mem_to_reg),
    .ctrl_branch(ctrl_branch));


program_counter program_counter(
    .clk(clk),
    .rst(rst),

    .ALU_zero_flag(ALU_zero_flag),
    .offset(offset),
    .ctrl_branch(ctrl_branch),

    .instruction_address(instruction_address));


instruction_memory instruction_memory(
    .instruction_address(instruction_address),
    .instruction_data(instruction));


register_file register_file(
    .clk(clk),
    .rst(rst),
    .reg_num_r0(instruction[19:15]),
    .reg_num_r1(instruction[24:20]),
    .reg_num_w(instruction[11:7]),
    .r_data_0(reg_read_data_0),
    .r_data_1(reg_read_data_1),
    .w_data(ctrl_mem_to_reg ? mem_read_data : ALU_data_out),
    .ctrl_reg_w(ctrl_reg_w),
    .debug(debug));


imm_generator imm_generator(
    .instruction(instruction),
    .offset(offset));


ALU_control ALU_control(
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .ALU_ctrl(ALU_ctrl),
    .ctrl_ALU_op(ctrl_ALU_op));


ALU ALU(
    .data_in_A(reg_read_data_0),
    .data_in_B(ctrl_ALU_src ? offset : reg_read_data_1),
    .data_out(ALU_data_out),
    .zero(ALU_zero_flag),
    .ALU_ctrl(ALU_ctrl));


data_memory data_memory(
    .clk(clk),
    .rst(rst),
    .w_data(reg_read_data_1),
    .r_data(mem_read_data),
    .address(ALU_data_out[DATA_MEMORY_ADDRESS_WIDTH - 1 : 0]),
    .ctrl_mem_w(ctrl_mem_w),
    .ctrl_mem_r(ctrl_mem_r));


endmodule