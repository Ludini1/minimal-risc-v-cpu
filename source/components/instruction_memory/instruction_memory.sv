import common_pkg::*;

module instruction_memory(
    instruction_address,
    instruction_data
);

    output  logic   [INSTRUCTION_WIDTH - 1 : 0]                 instruction_data;
    input   logic   [INSTRUCTION_MEMORY_ADDRESS_WIDTH - 1 : 0]  instruction_address;


    reg [INSTRUCTION_WIDTH - 1 : 0]  memory  [INSTRUCTION_MEMORY_DEPTH];    // 2MB-ish of instruction ROM with 32 bit instructions


    initial begin
        $readmemh("instruction_memory.mem", memory, INSTRUCTION_MEMORY_ADDRESS_WIDTH'('h0), INSTRUCTION_MEMORY_ADDRESS_WIDTH'('hFFFF));
    end

    assign instruction_data = memory[instruction_address];

endmodule