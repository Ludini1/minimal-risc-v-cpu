import common_pkg::*;

module clock_divider (

    clk_in,
    rst,
    clk_out
);

input   logic clk_in;
input   logic rst;
output  logic clk_out;

logic [27:0] counter; // The basys3 clock is 200MHZ so it should never need to count higher than 28 bits

initial begin
    counter = 28'd0;
end

always @(posedge clk_in or posedge rst)
begin
    if(rst) begin
        counter <= 28'd0;
    end else begin
        counter <= counter + 28'd1;
        if(counter >= (CLOCK_DIVISOR - 1))
            counter <= 28'd0;
    end

    clk_out <= (counter < CLOCK_DIVISOR / 2) ? 1'b1 : 1'b0;
end

endmodule