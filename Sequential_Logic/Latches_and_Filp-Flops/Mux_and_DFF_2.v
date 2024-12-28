module top_module (
    input clk,
    input w, R, E, L,
    output Q
);

    wire mux_0out, mux_1out;
    reg Q_out;
    assign mux_0out = E ? w : Q_out;
    assign mux_1out = L ? R : mux_0out;
    assign Q = Q_out;
    always @(posedge clk) begin
        Q_out <= mux_1out;
    end

endmodule
