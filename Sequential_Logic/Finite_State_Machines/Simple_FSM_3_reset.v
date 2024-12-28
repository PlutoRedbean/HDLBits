module top_module(
    input clk,
    input in,
    input reset,
    output reg out); //

    parameter A = 0, B = 1, C = 2, D = 3;
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
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            out <= 1'd0;
        end
        else begin
            out <= ( next_state == D );
        end
    end

endmodule
