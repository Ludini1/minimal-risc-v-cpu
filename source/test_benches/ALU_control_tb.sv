`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps
import common_pkg::*;

module ALU_control_tb;

    
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [1:0] ctrl_ALU_op;
    
    ALU_ctrl_t  ALU_ctrl;


    ALU_control UUT (
        .funct3(funct3),
        .funct7(funct7),
        .ALU_ctrl(ALU_ctrl),
        .ctrl_ALU_op(ctrl_ALU_op));

    localparam half_period = 5;
    localparam period      = half_period * 2;


    initial begin
        funct3      = 3'b0;
        funct7      = 7'b0;
        ctrl_ALU_op = 2'b0;

        #period; // load doubleword

        funct3 =  3'b011;
        funct7 = 7'b0;

        ctrl_ALU_op = 2'b0;

        #period; // store doubleword

        if (ALU_ctrl == ADD) begin
            $display("ALU_ctrl has expected value %b", ALU_ctrl);
        end else begin
            $display("ALU_ctrl has unexpected value %b", ALU_ctrl);
        end

        funct3 = 3'b011;
        funct7 = 7'b0;

        ctrl_ALU_op = 2'b00;

        #period; // add

        if (ALU_ctrl == ADD) begin
            $display("ALU_ctrl has expected value %b", ALU_ctrl);
        end else begin
            $display("ALU_ctrl has unexpected value %b ", ALU_ctrl);
        end

        funct3 = 3'b000;
        funct7 = 7'b0000000;

        ctrl_ALU_op = 2'b10;

        #period; // sub

        if (ALU_ctrl == ADD) begin
            $display("ALU_ctrl has expected value %b", ALU_ctrl);
        end else begin
            $display("ALU_ctrl has unexpected value %b", ALU_ctrl);
        end

        funct3 = 3'b000;
        funct7 = 7'b0100000;

        ctrl_ALU_op = 2'b10;

        #period; // and

        if (ALU_ctrl == SUB) begin
            $display("ALU_ctrl has expected value %b", ALU_ctrl);
        end else begin
            $display("ALU_ctrl has unexpected value %b", ALU_ctrl);
        end

        funct3 = 3'b111;
        funct7 = 7'b0000000;

        ctrl_ALU_op = 2'b10;

        #period; // or

        if (ALU_ctrl == AND) begin
            $display("ALU_ctrl has expected value %b", ALU_ctrl);
        end else begin
            $display("ALU_ctrl has unexpected value %b", ALU_ctrl);
        end

        funct3 = 3'b110;
        funct7 = 7'b0000000;

        ctrl_ALU_op = 2'b10;

        #period; // branch if equal

        if (ALU_ctrl == OR) begin
            $display("ALU_ctrl has expected value %b", ALU_ctrl);
        end else begin
            $display("ALU_ctrl has unexpected value %b", ALU_ctrl);
        end

        funct3 = 3'b000;
        funct7 = 7'b0;

        ctrl_ALU_op = 2'b01;

        #period;

        if (ALU_ctrl == SUB) begin
            $display("ALU_ctrl has expected value %b", ALU_ctrl);
        end else begin
            $display("ALU_ctrl has unexpected value %b", ALU_ctrl);
        end
    end


endmodule