`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps
import common_pkg::*;

module control_unit_tb;

    // THIS TESTBENCH IS OUTDATED

    i_inst_t    ld_test     = '{12'b000000001111, 5'b00100, 3'b011, 5'b01000, LOAD};

    s_inst_t    sd_test     = '{7'b0000000, 5'b01000, 5'b00100, 3'b011, 5'b01111, STORE};

    r_inst_t    arith_test    = '{7'b0000000, 5'b01000, 5'b00100, 3'b000, 5'b10000, ARITH};

    sb_inst_t   beq_test    = '{1'b0, 6'b000000, 5'b01000, 5'b00100, 3'b000, 4'b1111, 1'b0, BRANCH};

    opcode_t    opcode;

    logic [1:0] ctrl_ALU_op;
    logic       ctrl_ALU_src;
    logic       ctrl_reg_w;
    logic       ctrl_mem_w;
    logic       ctrl_mem_r;
    logic       ctrl_mem_to_reg;
    logic       ctrl_branch;


    control_unit UUT (
        .opcode(opcode),
        .ctrl_ALU_op(ctrl_ALU_op),
        .ctrl_ALU_src(ctrl_ALU_src),
        .ctrl_reg_w(ctrl_reg_w),
        .ctrl_mem_w(ctrl_mem_w),
        .ctrl_mem_r(ctrl_mem_r),
        .ctrl_mem_to_reg(ctrl_mem_to_reg),
        .ctrl_branch(ctrl_branch));


    localparam half_period = 5;
    localparam period      = half_period * 2;

    initial begin
        opcode = LOAD;

        #period; // load doubleword

        opcode = ld_test.opcode;

        #period; // store doubleword

        if (ctrl_ALU_src    == 1'b1 &&
            ctrl_mem_to_reg == 1'b1 &&
            ctrl_reg_w      == 1'b1 &&
            ctrl_mem_r      == 1'b1 &&
            ctrl_mem_w      == 1'b0 &&
            ctrl_branch     == 1'b0 &&
            ctrl_ALU_op     == 2'b00) begin
            $display("control lines nominal for opcode %b", opcode);
        end else begin
            $display("control lines unexpected value %b", opcode);
        end

        opcode = sd_test.opcode;

        #period; // arithmetic

        if (ctrl_ALU_src    == 1'b1 &&
            ctrl_mem_to_reg == 1'b0 &&
            ctrl_reg_w      == 1'b0 &&
            ctrl_mem_r      == 1'b0 &&
            ctrl_mem_w      == 1'b1 &&
            ctrl_branch     == 1'b0 &&
            ctrl_ALU_op     == 2'b00) begin
            $display("control lines nominal for opcode %b", opcode);
        end else begin
            $display("control lines unexpected value %b", opcode);
        end

        opcode = arith_test.opcode;

        #period; // branch if equal

        if (ctrl_ALU_src    == 1'b0 &&
            ctrl_mem_to_reg == 1'b0 &&
            ctrl_reg_w      == 1'b1 &&
            ctrl_mem_r      == 1'b0 &&
            ctrl_mem_w      == 1'b0 &&
            ctrl_branch     == 1'b0 &&
            ctrl_ALU_op     == 2'b10) begin
            $display("control lines nominal for opcode %b", opcode);
        end else begin
            $display("control lines unexpected value %b", opcode);
        end

        opcode = beq_test.opcode;

        #period;

        if (ctrl_ALU_src    == 1'b0 &&
            ctrl_mem_to_reg == 1'b0 &&
            ctrl_reg_w      == 1'b0 &&
            ctrl_mem_r      == 1'b0 &&
            ctrl_mem_w      == 1'b0 &&
            ctrl_branch     == 1'b1 &&
            ctrl_ALU_op     == 2'b01) begin
            $display("control lines nominal for opcode %b", opcode);
        end else begin
            $display("control lines unexpected value %b", opcode);
        end

    end
endmodule