`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps
import common_pkg::*;

module instruction_memory_tb;

    logic   [INSTRUCTION_MEMORY_ADDRESS_WIDTH - 1 : 0]  instruction_address;
    logic   [INSTRUCTION_WIDTH - 1 : 0]                 instruction_data;

    localparam period = 5;

    instruction_memory UUT (
        .instruction_address(instruction_address),
        .instruction_data(instruction_data));
    
    initial
        begin
            instruction_address = 16'h0000;

            if (instruction_data == 32'h02103083) begin
                $display("instruction data has expected value %h", instruction_data);
            end else begin
                $display("instruction has unexpected value %d ", instruction_data);
            end

            #period;

            instruction_address = 16'h0001;

            if (instruction_data == 32'hAFBFCFDF) begin
                $display("instruction data has expected value %h", instruction_data);
            end else begin
                $display("instruction has unexpected value %d ", instruction_data);
            end

            #period;

            instruction_address = 16'h0002;

            if (instruction_data == 32'h7034EF55) begin
                $display("instruction data has expected value %h", instruction_data);
            end else begin
                $display("instruction has unexpected value %d ", instruction_data);
            end

            #period;

            instruction_address = 16'h0003;

            if (instruction_data == 32'h11223344) begin
                $display("instruction data has expected value %h", instruction_data);
            end else begin
                $display("instruction has unexpected value %d ", instruction_data);
            end

            #period;

            instruction_address = 16'h0004;

            if (instruction_data == 32'hDEADBEEF) begin
                $display("instruction data has expected value %h", instruction_data);
            end else begin
                $display("instruction has unexpected value %d ", instruction_data);
            end

            #period;

            instruction_address = 16'h0005;

            if (instruction_data == 32'hDEADBEEF) begin
                $display("instruction data has expected value %h", instruction_data);
            end else begin
                $display("instruction has unexpected value %d ", instruction_data);
            end

        end

endmodule