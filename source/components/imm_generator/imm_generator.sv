import common_pkg::*;

module imm_generator (
    instruction,
    offset
);

    input   logic           [INSTRUCTION_WIDTH - 1 : 0] instruction;
    output  logic signed    [RISC_V_DATA_WIDTH - 1 : 0] offset;

    opcode_t opcode;

    logic [11:0] imm;

    assign opcode = opcode_t'(instruction[6:0]);

    always_comb begin
        case (opcode)
            LOAD    : imm = instruction [31:20];
            STORE   : imm = {instruction[31:25], instruction [11:7]};
            BRANCH  : imm = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};

            default : imm = 12'b0;
        endcase
    end

    assign offset = RISC_V_DATA_WIDTH'(signed'(imm));

endmodule