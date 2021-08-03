import common_pkg::*;

module register_file (

    clk,
    rst,

    reg_num_r0,
    reg_num_r1,
    reg_num_w,

    r_data_0,
    r_data_1,
    w_data,

    ctrl_reg_w,

    debug

    );


    input   logic                                       clk;                        // clock
    input   logic                                       rst;                        // reset

    input   logic [REGISTER_FILE_ADDRESS_WIDTH - 1 : 0] reg_num_r0;                 // register selection read 0
    input   logic [REGISTER_FILE_ADDRESS_WIDTH - 1 : 0] reg_num_r1;                 // register selection read 1
    input   logic [REGISTER_FILE_ADDRESS_WIDTH - 1 : 0] reg_num_w;                  // register selection write

    output  logic [RISC_V_DATA_WIDTH - 1 : 0]           r_data_0;                   // read data output 0
    output  logic [RISC_V_DATA_WIDTH - 1 : 0]           r_data_1;                   // read data output 1
    input   logic [RISC_V_DATA_WIDTH - 1 : 0]           w_data;                     // write data input

    input   logic                                       ctrl_reg_w;                 // Enables writing to registers on a clock edge

    output  logic [15:0]    debug;                                                  // debug port


    logic [RISC_V_DATA_WIDTH - 1 : 0] RF [REGISTER_FILE_NUM];                       // 32 individual 64-bit registers to be fetched

    integer i;

    initial begin
        for (i = 0; i < REGISTER_FILE_NUM; i = i + 1) RF[i] = RISC_V_DATA_WIDTH'('b0);
    end

    assign r_data_0 = RF[reg_num_r0];
    assign r_data_1 = RF[reg_num_r1];
    assign debug    = RF[31][15:0];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            integer i;
            for (i = 0; i < REGISTER_FILE_NUM; i = i + 1) RF[i] <= RISC_V_DATA_WIDTH'('b0);
        end else begin
            if (ctrl_reg_w) begin
                RF[reg_num_w] <= w_data;
            end
        end
    end

endmodule