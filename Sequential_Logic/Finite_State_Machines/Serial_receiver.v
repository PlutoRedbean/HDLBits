module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done
); 
    
    parameter START = 3'd0,
              START_DONE = 3'd1,
              STOP = 3'd2,
              DATA = 3'd3,
              NONE = 3'd4,
              NONE_DONE = 3'd5;
    reg [2:0] state, next;
    reg [3:0] count;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            START      : next = DATA;
            START_DONE : next = DATA;
            DATA : begin
                if      ( count >= 4'd8 &  in ) next = STOP;
                else if ( count >= 4'd8 & ~in ) next = NONE;
                else if ( count <  4'd8       ) next = DATA;
            end
            STOP       : next = in ? START : NONE;
            NONE       : next = in ? START : NONE;
            NONE_DONE  : next = in ? START : NONE;
            default    : next = state;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= NONE;
            count <= 4'd0;
        end
        else begin
            if (next != STOP & next != NONE & next != START) begin
                count <= count + 4'd1;
            end
            else begin
                count <= 4'd0;
            end
            state <= next;
        end
    end
    // Output logic
    always @(*) begin
        done = (state == START_DONE | state == NONE_DONE);
    end

endmodule
