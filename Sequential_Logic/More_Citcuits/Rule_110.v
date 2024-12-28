module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 

    integer i;
    reg [511:0] result;

    always @(posedge clk) begin
        if (load) begin
            result <= data;
        end
        else begin
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    result[0] <= result[0];
                end
                else if (i == 511) begin
                    result[511] <= result[511] | result[510];
                end
                else begin
                    result[i] <= ~( ( result[i + 1] &  result[i] &  result[i - 1]) | 
                                    (~result[i + 1] & ~result[i] & ~result[i - 1]) | 
                                    ( result[i + 1] & ~result[i] & ~result[i - 1]) );
                end
            end
        end
    end

    assign q = result;

endmodule
