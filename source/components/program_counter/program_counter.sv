import common_pkg::*;

module program_counter (
    clk,
    rst,

    ALU_zero_flag,
    offset,
    ctrl_branch,

    instruction_address
);

    input   logic   clk;
    input   logic   rst;

    input   logic                                       ALU_zero_flag;
    input   logic signed [RISC_V_DATA_WIDTH - 1 : 0]    offset;
    input   logic                                       ctrl_branch;

    output  logic [INSTRUCTION_MEMORY_ADDRESS_WIDTH - 1 : 0] instruction_address = INSTRUCTION_MEMORY_ADDRESS_WIDTH'('b0);;

    //initial begin
    //    instruction_address = INSTRUCTION_MEMORY_ADDRESS_WIDTH'('b0);
    //end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            instruction_address <= INSTRUCTION_MEMORY_ADDRESS_WIDTH'('b0);
        end else begin
            if (ALU_zero_flag && ctrl_branch) begin // This line isn't elaborated correctly (works fine in synthesis)? It's possible to trick Vivado using DeMorgan's law
                instruction_address <= instruction_address + (offset[RISC_V_DATA_WIDTH - 1 : 0] << 1);
            end else begin
                instruction_address <= instruction_address + INSTRUCTION_MEMORY_ADDRESS_WIDTH'('b1);
            end
        end
    end


endmodule