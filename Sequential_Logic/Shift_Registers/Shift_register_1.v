module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);

    reg [3:0] Q;

    always @(posedge clk) begin
        if (~resetn) begin
            Q <= 4'h0;
        end
        else begin
            Q[3] <= in;
            Q[2] <= Q[3];
            Q[1] <= Q[2];
            Q[0] <= Q[1];
        end
    end

    assign out = Q[0];

endmodule
