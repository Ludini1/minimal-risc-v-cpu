package common_pkg;

    // General
    parameter INSTRUCTION_WIDTH                 = 32;
    parameter RISC_V_DATA_WIDTH                 = 64;
    parameter CLOCK_DIVISOR                     = 200000000; // Produces 1 HZ clock from 200 MHZ

    // Register File
    parameter REGISTER_FILE_NUM                 = 32;
    parameter REGISTER_FILE_ADDRESS_WIDTH       = 5;


    // Instruction Memory
    parameter INSTRUCTION_MEMORY_DEPTH          = 256;
    parameter INSTRUCTION_MEMORY_ADDRESS_WIDTH  = 8;

    // Data Memory
    parameter DATA_MEMORY_ADDRESS_WIDTH = 9;

    parameter DATA_MEMORY_ROM_DEPTH = 256;
    parameter DATA_MEMORY_RAM_DEPTH = 256;

    // ALU
    typedef enum logic [2:0] {
        AND = 3'b000,
        OR  = 3'b001,
        ADD = 3'b010,
        SUB = 3'b110
    } ALU_ctrl_t;

    // Instructions

    typedef enum logic [6:0] {
        LOAD    = 7'b0000011,
        STORE   = 7'b0100011,
        ARITH   = 7'b0110011,
        BRANCH  = 7'b1100011
    } opcode_t;


    

endpackage