`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps
import common_pkg::*;

module program_counter_tb;
    

    // Program Counter
    logic                                               clk;
    logic                                               rst;
    logic                                               ALU_zero_flag;
    logic signed   [RISC_V_DATA_WIDTH - 1 : 0]          offset;
    logic                                               ctrl_branch;

    // Connections
    logic   [INSTRUCTION_MEMORY_ADDRESS_WIDTH - 1 : 0]  instruction_address;

    // Instruction Memory
    logic   [INSTRUCTION_WIDTH - 1 : 0]                 instruction_data;

    // Simulation Parameters
    localparam half_period = 5;
    localparam period      = half_period * 2;


    program_counter program_counter(
        .clk(clk),
        .rst(rst),

        .ALU_zero_flag(ALU_zero_flag),
        .offset(offset),
        .ctrl_branch(ctrl_branch),

        .instruction_address(instruction_address));


    instruction_memory instruction_memory(
        .instruction_address(instruction_address),
        .instruction_data(instruction_data));


    initial begin
        clk = 1'b0;
        rst = 1'b0;
        
        ALU_zero_flag   = 1'b0;
        offset          = RISC_V_DATA_WIDTH'('b0);
        ctrl_branch     = 1'b0;

        #period;

        if (instruction_data == INSTRUCTION_WIDTH'('h00208FE3)) begin
            $display("instruction data has expected value %h", instruction_data);
        end else begin
            $display("instruction has unexpected value %h ", instruction_data);
        end

        #period;

        if (instruction_data == INSTRUCTION_WIDTH'('h000100B3)) begin
            $display("instruction data has expected value %h", instruction_data);
        end else begin
            $display("instruction has unexpected value %h ", instruction_data);
        end

        #period;

        if (instruction_data == INSTRUCTION_WIDTH'('h00058133)) begin
            $display("instruction data has expected value %h", instruction_data);
        end else begin
            $display("instruction has unexpected value %h ", instruction_data);
        end

        #period;

        if (instruction_data == INSTRUCTION_WIDTH'('h00058133)) begin
            $display("instruction data has expected value %h", instruction_data);
        end else begin
            $display("instruction has unexpected value %h ", instruction_data);
        end

        #period;

        if (instruction_data == INSTRUCTION_WIDTH'('hFE000FCB)) begin
            $display("instruction data has expected value %h", instruction_data);
        end else begin
            $display("instruction has unexpected value %h ", instruction_data);
        end

        ALU_zero_flag   = 1'b1;
        ctrl_branch     = 1'b1;

        offset          = RISC_V_DATA_WIDTH'(-2);

        #period;

        if (instruction_data == INSTRUCTION_WIDTH'('h000100B3)) begin
            $display("instruction data has expected value %h", instruction_data);
        end else begin
            $display("instruction has unexpected value %h ", instruction_data);
        end

        ALU_zero_flag   = 1'b0;
        ctrl_branch     = 1'b0;

        offset          = RISC_V_DATA_WIDTH'(0);

    end

    always
        #half_period clk = !clk;

endmodule