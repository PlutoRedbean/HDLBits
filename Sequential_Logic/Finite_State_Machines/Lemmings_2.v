module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    parameter LEFT = 2'b00, RIGHT = 2'b01, FALL_LEFT = 2'b10, FALL_RIGHT = 2'b11;
    reg [1:0] state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            LEFT : begin
                next_state <= state;
                if (ground & bump_left & bump_right) next_state <= RIGHT;
                else if (ground & bump_right) next_state <= LEFT;
                else if (ground & bump_left) next_state <= RIGHT;
                else if (~ground) next_state <= FALL_LEFT;
            end
            RIGHT : begin
                next_state <= state;
                if (ground & bump_left & bump_right) next_state <= LEFT;
                else if (ground & bump_right) next_state <= LEFT;
                else if (ground & bump_left) next_state <= RIGHT;
                else if (~ground) next_state <= FALL_RIGHT;
            end
            FALL_LEFT : begin
                if (ground) next_state <= LEFT;
                else next_state <= FALL_LEFT;
            end
            FALL_RIGHT : begin
                if (ground) next_state <= RIGHT;
                else next_state <= FALL_RIGHT;
            end
            default : begin
                next_state <= state;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            walk_left  <= 1'd1;
            walk_right <= 1'd0;
            aaah       <= 1'd0;
        end
        else begin
            walk_left  <= (next_state == LEFT);
            walk_right <= (next_state == RIGHT);
            aaah       <= (next_state == FALL_LEFT || next_state == FALL_RIGHT);
        end
    end

endmodule
