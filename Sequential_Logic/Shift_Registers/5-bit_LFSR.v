module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 

    reg [4:0] result;

    always @(posedge clk) begin
        if (reset) begin
            result <= 5'h1;
        end
        else begin
            result[4] <= 1'b0 ^ result[0];
            result[3] <= result[4];
            result[2] <= result[3] ^ result[0];
            result[1] <= result[2];
            result[0] <= result[1];
        end
    end

    assign q = result;

endmodule
