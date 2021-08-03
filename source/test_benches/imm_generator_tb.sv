`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps
import common_pkg::*;

module imm_generator_tb;
    logic [INSTRUCTION_WIDTH - 1 : 0]   instruction;
    longint signed                      offset;

    
    logic [INSTRUCTION_WIDTH - 1 : 0] ld_test       = 32'b00000000111100100011010000000011;
    logic [INSTRUCTION_WIDTH - 1 : 0] sd_test       = 32'b10000010100000100011011110100011;
    logic [INSTRUCTION_WIDTH - 1 : 0] arith_test    = 32'b00000000100000100000100000110011;
    logic [INSTRUCTION_WIDTH - 1 : 0] beq_test      = 32'b10100100100000100000111101100011;

    imm_generator UUT (
        .instruction(instruction),
        .offset(offset));

    localparam half_period = 5;
    localparam period      = half_period * 2;

    initial begin
        instruction = ld_test;
        #period;
        if (offset == 15) begin
            $display("offset has expected value %d", offset);
        end else begin
            $display("offset has unexpected value %d ", offset);
        end
        instruction = sd_test;
        #period;
        if (offset == -2001) begin
            $display("offset has expected value %d", offset);
        end else begin
            $display("offset has unexpected value %d ", offset);
        end
        instruction = arith_test;
        #period;
        if (offset == 0) begin
            $display("offset has expected value %d", offset);
        end else begin
            $display("offset has unexpected value %d ", offset);
        end
        instruction = beq_test;
        #period;
        if (offset == -1745) begin
            $display("offset has expected value %d", offset);
        end else begin
            $display("offset has unexpected value %d ", offset);
        end
        
    end
endmodule