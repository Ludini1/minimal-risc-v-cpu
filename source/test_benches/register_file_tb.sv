`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module register_file_tb;

    logic clk;
    logic rst;

    logic   [4:0]   reg_num_r0;
    logic   [4:0]   reg_num_r1;
    logic   [4:0]   reg_num_w;

    logic   [63:0]  r_data_0;
    logic   [63:0]  r_data_1;
    logic   [63:0]  w_data;

    logic ctrl_reg_w;

    localparam half_period = 5;
    localparam period      = half_period * 2;

    register_file UUT (
        .clk(clk),
        .rst(rst),

        .reg_num_r0(reg_num_r0),
        .reg_num_r1(reg_num_r1),
        .reg_num_w(reg_num_w),
        
        .r_data_0(r_data_0),
        .r_data_1(r_data_1),
        .w_data(w_data),
        .ctrl_reg_w(ctrl_reg_w));
    
    initial
        begin

            clk         = 1'b0;
            rst         = 1'b0;

            reg_num_r0  = 5'b0;
            reg_num_r1  = 5'b0;
            reg_num_w   = 5'b0;

            ctrl_reg_w  = 1'b0;

            #period; // write 123 to register 4

            ctrl_reg_w  = 1;
            reg_num_w   = 4;
            w_data      = 123;

            #period; // write 42069 to register 13

            reg_num_w   = 13;
            w_data      = 42069;

            #period; // read from register 4 and 13
            
            reg_num_r0  = 4;
            reg_num_r1  = 13;

            #period; // print read output

            if (r_data_0 == 123) begin
                $display("r_data_0 has expected value %d", r_data_0);
            end else begin
                $display("r_data_0 has unexpected value %d ", r_data_0);
            end

            if (r_data_1 == 42069) begin
                $display("r_data_1 has expected value %d", r_data_1);
            end else begin
                $display("r_data_1 has unexpected value %d ", r_data_1);
            end

            reg_num_w   = 0;
            w_data      = 1234;

            #period;

            reg_num_r0  = 0;
            reg_num_r1  = 0;

            #period;
            
            if (r_data_0 == 1234) begin
                $display("r_data_0 has expected value %d", r_data_0);
            end else begin
                $display("r_data_0 has unexpected value %d ", r_data_0);
            end

            if (r_data_1 == 1234) begin
                $display("r_data_1 has expected value %d", r_data_1);
            end else begin
                $display("r_data_1 has unexpected value %d ", r_data_1);
            end

            #period;

            w_data      = 7777;

            #period;

            if (r_data_0 == 7777) begin
                $display("r_data_0 has expected value %d", r_data_0);
            end else begin
                $display("r_data_0 has unexpected value %d ", r_data_0);
            end

            if (r_data_1 == 7777) begin
                $display("r_data_1 has expected value %d", r_data_1);
            end else begin
                $display("r_data_1 has unexpected value %d ", r_data_1);
            end

        end

    always
        #half_period clk = !clk;

endmodule