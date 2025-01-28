module top_module (
    input clk,
    input [2:0] y,
    input x,
    output reg Y0,
    output reg z
);

    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100;

    // State transition logic (combinational)
    always @(*) begin
        case (y)
            A : Y0 = x ? 1'd1 : 1'd0;
            B : Y0 = x ? 1'd0 : 1'd1;
            C : Y0 = x ? 1'd1 : 1'd0;
            D : Y0 = x ? 1'd0 : 1'd1;
            E : Y0 = x ? 1'd0 : 1'd1;
            default : Y0 = 1'd0;
        endcase
    end

    // State flip-flops (sequential)

    // Output logic
    always @(*) begin
        z <= (y == D || y == E);
    end

endmodule
