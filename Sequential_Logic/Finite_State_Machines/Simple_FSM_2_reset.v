module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output reg out); //  

    parameter OFF = 1'b0, ON = 1'b1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        if (state == OFF) begin
            next_state = j ? ON : OFF;
        end
        else begin
            next_state = k ? OFF : ON;
        end
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if (reset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if (reset) begin
            out <= 1'd0;
        end
        else begin
            out <= next_state;
        end
    end

endmodule
