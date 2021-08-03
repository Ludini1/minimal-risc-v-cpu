import common_pkg::*;

module ALU (

    data_in_A,
    data_in_B,
    data_out,

    zero,

    ALU_ctrl
);

    input   logic signed    [RISC_V_DATA_WIDTH - 1 : 0]     data_in_A;
    input   logic signed    [RISC_V_DATA_WIDTH - 1 : 0]     data_in_B;
    output  logic signed    [RISC_V_DATA_WIDTH - 1 : 0]     data_out;

    output  logic                                   zero;

    input   ALU_ctrl_t                              ALU_ctrl;

    assign zero = (data_out == RISC_V_DATA_WIDTH'('b0));

    always_comb
    begin
        case (ALU_ctrl)
            AND: data_out = data_in_A & data_in_B;
            OR:  data_out = data_in_A | data_in_B;
            ADD: data_out = data_in_A + data_in_B;
            SUB: data_out = data_in_A - data_in_B;
            default: data_out = RISC_V_DATA_WIDTH'('b0);
        endcase
    end
    
endmodule

