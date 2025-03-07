module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
); 

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else if (ena && amount == 2'b00) begin
            q <= {q[62:0], 1'b0};
        end
        else if (ena && amount == 2'b01) begin
            q <= {q[55:0], 8'b0};
        end
        else if (ena && amount == 2'b10) begin
            q <= {q[63], q[63:1]};
        end
        else if (ena && amount == 2'b11) begin
            q <= {q[63] ? 8'b11111111 : 8'b00000000, q[63:8]};
        end
        else begin
            q <= q;
        end
    end

endmodule
