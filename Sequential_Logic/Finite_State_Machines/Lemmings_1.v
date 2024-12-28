module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
); //  

    parameter LEFT = 1'b0, RIGHT = 1'b1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        next_state = state;
        if ( bump_left & bump_right ) begin
            case (state)
                LEFT : next_state = RIGHT;
                RIGHT : next_state = LEFT;
            endcase
        end
        else if ( bump_right ) begin
            next_state = LEFT;
        end
        else if ( bump_left ) begin
            next_state = RIGHT;
        end
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
        end
        else begin
            walk_left <= (next_state == LEFT);
            walk_right <= (next_state == RIGHT);
        end
    end

endmodule
