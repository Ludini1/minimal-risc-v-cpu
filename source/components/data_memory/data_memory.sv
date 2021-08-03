import common_pkg::*;

module data_memory (

    clk,
    rst,

    w_data,
    r_data,

    address,

    ctrl_mem_w,
    ctrl_mem_r

);

    input   logic                                       clk;
    input   logic                                       rst;

    input   logic [RISC_V_DATA_WIDTH - 1 : 0]           w_data;
    output  logic [RISC_V_DATA_WIDTH - 1 : 0]           r_data;

    input   logic [DATA_MEMORY_ADDRESS_WIDTH - 1 : 0]   address;

    input   logic                                       ctrl_mem_w;
    input   logic                                       ctrl_mem_r;


    reg [RISC_V_DATA_WIDTH - 1 : 0]  rom_memory  [DATA_MEMORY_ROM_DEPTH];
    reg [RISC_V_DATA_WIDTH - 1 : 0]  ram_memory  [DATA_MEMORY_RAM_DEPTH];

    
    integer i;

    initial begin
        $readmemh(  "data_memory.mem",
                    rom_memory, 
                    DATA_MEMORY_ADDRESS_WIDTH'('h0),
                    DATA_MEMORY_ADDRESS_WIDTH'('hFF));


        for (i = 0; i < DATA_MEMORY_RAM_DEPTH; i = i + 1) ram_memory[i] = RISC_V_DATA_WIDTH'('b0);
    end


    always_comb begin
        if (ctrl_mem_r) begin
            if (address < DATA_MEMORY_ROM_DEPTH) begin
                r_data = rom_memory[address];
            end else begin
                r_data = ram_memory[address - DATA_MEMORY_ROM_DEPTH];
            end
        end else begin
            r_data = RISC_V_DATA_WIDTH'('b0);
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            integer i;
            for (i = 0; i < DATA_MEMORY_RAM_DEPTH; i = i + 1) ram_memory[i] <= RISC_V_DATA_WIDTH'('b0);
        end else begin
            if (ctrl_mem_w && (address > DATA_MEMORY_ROM_DEPTH)) begin
                ram_memory[address - DATA_MEMORY_ROM_DEPTH] <= w_data;
            end
        end
    end

endmodule