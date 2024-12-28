module top_module(
    input clk,
    input in,
    input areset,
    output reg out); //

    parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
    reg [1:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A : next_state = in ? B : A;
            B : next_state = in ? B : C;
            C : next_state = in ? D : A;
            D : next_state = in ? B : C;
            default : next_state = state;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            out <= 1'd0;
        end
        else begin
            out <= ( next_state == D );
        end
    end

endmodule
