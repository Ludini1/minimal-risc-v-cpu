`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps
import common_pkg::*;

module ALU_tb;

    logic   [RISC_V_DATA_WIDTH - 1 : 0]     data_in_A;
    logic   [RISC_V_DATA_WIDTH - 1 : 0]     data_in_B;
    logic   [RISC_V_DATA_WIDTH - 1 : 0]     data_out;
    logic                                   zero;
    ALU_ctrl_t                              ALU_ctrl;

    localparam half_period = 5;
    localparam period      = half_period * 2;

    ALU UUT (
        .data_in_A(data_in_A),
        .data_in_B(data_in_B),
        .data_out(data_out),
        .zero(zero),
        .ALU_ctrl(ALU_ctrl));

    initial begin
        ALU_ctrl = AND;

        data_in_A = 64'b0;
        data_in_B = 64'b0;

        #period;

        data_in_A = 64'd223;
        data_in_B = 64'd132;

        #period;

        if (data_out == 64'd223 & 64'd132) begin
            $display("data_out has expected value %d", data_out);
        end else begin
            $display("data_out has unexpected value %d ", data_out);
        end

        ALU_ctrl = OR;

        data_in_A = 64'd4013;
        data_in_B = 64'd3022;

        #period;

        if (data_out == 64'd4013 | 64'd3022) begin
            $display("data_out has expected value %d", data_out);
        end else begin
            $display("data_out has unexpected value %d ", data_out);
        end

        ALU_ctrl = ADD;

        data_in_A = 64'd5555;
        data_in_B = 64'd4321;

        #period;

        if (data_out == 64'd5555 + 64'd4321) begin
            $display("data_out has expected value %d", data_out);
        end else begin
            $display("data_out has unexpected value %d ", data_out);
        end

        ALU_ctrl = SUB;

        data_in_A = 64'd999999;
        data_in_B = 64'd111111;

        #period;

        if (data_out == 64'd999999 - 64'd111111) begin
            $display("data_out has expected value %d", data_out);
        end else begin
            $display("data_out has unexpected value %d ", data_out);
        end

    end

endmodule