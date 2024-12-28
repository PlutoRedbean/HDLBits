module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg done
); //

    parameter NONE  = 3'd0,
              BYTE1 = 3'd1,
              BYTE2 = 3'd2,
              BYTE3 = 3'd3,
              NONE_DONE = 3'd4,
              BYTE1_DONE = 3'd5;
    reg [2:0] state, next, count;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            NONE       : next = in[3] ? BYTE1 : NONE;
            NONE_DONE  : next = in[3] ? BYTE1 : NONE;
            BYTE1      : next = BYTE2;
            BYTE1_DONE : next = BYTE2;
            BYTE2      : next = BYTE3;
            BYTE3      : begin
                if (count >= 3'd3 & in[3]) next = BYTE1_DONE;
                else if (count >= 3'd3 & ~in[3]) next = NONE_DONE;
                else if (count <  3'd3 &  in[3]) next = BYTE1;
                else next = NONE;
            end
            default : next = state;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= NONE;
            count <= 3'd0;
        end
        else begin
            state <= next;
            if (next != NONE & next != NONE_DONE & count < 3'd3) begin
                count <= count + 3'd1;
            end
            else if (next == NONE_DONE) begin
                count <= 3'd0;
            end
            else if (next == BYTE1_DONE) begin
                count <= 3'd1;
            end
        end
    end
    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'd0;
        end
        else begin
            done <= (next == NONE_DONE | next == BYTE1_DONE);
        end
    end

endmodule
