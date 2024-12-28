module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    parameter LEFT = 3'b000, RIGHT = 3'b001, FALL_LEFT = 3'b010, FALL_RIGHT = 3'b011, DIG_LEFT = 3'b100, DIG_RIGHT = 3'b101;
    reg [2:0] state, next_state;

    always @(*) begin
        // State transition logic
        case (state)
            LEFT : begin
                next_state = state;
                if (~dig & ground & bump_left & bump_right) next_state = RIGHT;
                else if (~dig & ground & bump_right) next_state = LEFT;
                else if (~dig & ground & bump_left) next_state = RIGHT;
                else if ( dig & ground) next_state = DIG_LEFT;
                else if (~ground) next_state = FALL_LEFT;
            end
            RIGHT : begin
                next_state = state;
                if (~dig & ground & bump_left & bump_right) next_state = LEFT;
                else if (~dig & ground & bump_right) next_state = LEFT;
                else if (~dig & ground & bump_left) next_state = RIGHT;
                else if ( dig & ground) next_state = DIG_RIGHT;
                else if (~ground) next_state = FALL_RIGHT;
            end
            FALL_LEFT : begin
                if (ground) next_state = LEFT;
                else next_state = FALL_LEFT;
            end
            FALL_RIGHT : begin
                if (ground) next_state = RIGHT;
                else next_state = FALL_RIGHT;
            end
            DIG_LEFT : begin
                if (~ground) next_state = FALL_LEFT;
                else next_state = DIG_LEFT;
            end
            DIG_RIGHT : begin
                if (~ground) next_state = FALL_RIGHT;
                else next_state = DIG_RIGHT;
            end
            default : begin
                next_state = state;
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
            digging    <= 1'd0;
        end
        else begin
            walk_left  <= (next_state == LEFT);
            walk_right <= (next_state == RIGHT);
            aaah       <= (next_state == FALL_LEFT || next_state == FALL_RIGHT);
            digging    <= (next_state == DIG_LEFT | next_state == DIG_RIGHT);
        end
    end

endmodule
