module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    MUXDFF U0_MUXDFF (
        .R(SW[0]),
        .clk(KEY[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .w(LEDR[1]),
        .Q(LEDR[0])
    );
    MUXDFF U1_MUXDFF (
        .R(SW[1]),
        .clk(KEY[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .w(LEDR[2]),
        .Q(LEDR[1])
    );
    MUXDFF U2_MUXDFF (
        .R(SW[2]),
        .clk(KEY[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .w(LEDR[3]),
        .Q(LEDR[2])
    );
    MUXDFF U3_MUXDFF (
        .R(SW[3]),
        .clk(KEY[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .w(KEY[3]),
        .Q(LEDR[3])
    );
    
endmodule

module MUXDFF (
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
