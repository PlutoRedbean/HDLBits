module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 

    parameter LEADING_ZERO = 2'd0,
              LEADING_ONE  = 2'd1,
              REVERSE      = 2'd2;

    reg [1:0] state, next;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            LEADING_ZERO : next = x ? LEADING_ONE : LEADING_ZERO;
            LEADING_ONE  : next = REVERSE;
            REVERSE      : next = REVERSE;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEADING_ZERO;
        end
        else begin
            state <= next;
        end
    end

    // Output logic
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            z <= 1'd0;
        end
        else begin
            z <= (next == REVERSE) ? (~x) : x;
        end
    end

endmodule
