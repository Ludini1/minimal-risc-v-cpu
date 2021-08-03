`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps
import common_pkg::*;

module data_memory_tb;

    logic                                       clk;
    logic                                       rst;
    logic [RISC_V_DATA_WIDTH - 1 : 0]           w_data;
    logic [RISC_V_DATA_WIDTH - 1 : 0]           r_data;
    logic [DATA_MEMORY_ADDRESS_WIDTH - 1 : 0]   address;
    logic                                       ctrl_mem_w;
    logic                                       ctrl_mem_r;

    localparam half_period = 5;
    localparam period      = half_period * 2;

    data_memory UUT (
        .clk(clk),
        .rst(rst),
        .w_data(w_data),
        .r_data(r_data),
        .address(address),
        .ctrl_mem_w(ctrl_mem_w),
        .ctrl_mem_r(ctrl_mem_r));

    initial begin
        clk         = 1'b0;
        rst         = 1'b0;
        w_data      = 64'b0;
        address     = 9'b0;
        ctrl_mem_w  = 1'b0;

        #period;

        ctrl_mem_w  = 1'b1;
        address     = 9'h1AB;
        w_data      = 64'hFEDCBA9876543210;

        #period;

        address     = 9'h169;
        w_data      = 64'hAAAAAAAABBBBBBBB;

        #period;

        address     = 9'h103;
        w_data      = 64'h0000123412341234;

        #period;

        ctrl_mem_w  = 1'b0;
        w_data      = 64'h0000000000000000;

        ctrl_mem_r  = 1'b1;
        address     = 9'h1AB;

        #period;

        if (r_data == 64'hFEDCBA9876543210) begin
            $display("read data has expected value %h", r_data);
        end else begin
            $display("read has unexpected value %h", r_data);
        end

        address     = 9'h169;

        #period;

        if (r_data == 64'hAAAAAAAABBBBBBBB) begin
            $display("read data has expected value %h", r_data);
        end else begin
            $display("read has unexpected value %h", r_data);
        end

        address     = 9'h103;

        #period;

        if (r_data == 64'h0000123412341234) begin
            $display("read data has expected value %h", r_data);
        end else begin
            $display("read has unexpected value %h", r_data);
        end

        address     = 98'h0000;

        #period;

        if (r_data == 64'h0123456789ABCDEF) begin
            $display("read data has expected value %h", r_data);
        end else begin
            $display("read has unexpected value %h", r_data);
        end

        address     = 9'h0001;

        #period;

        if (r_data == 64'hDEADBEEFDEADBEEF) begin
            $display("read data has expected value %h", r_data);
        end else begin
            $display("read has unexpected value %h", r_data);
        end

        address     = 9'h0006;

        #period;

        if (r_data == 64'hABABABABABABABAB) begin
            $display("read data has expected value %h", r_data);
        end else begin
            $display("read has unexpected value %h", r_data);
        end

    end

    always
        #half_period clk = !clk;

endmodule