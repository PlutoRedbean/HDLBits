module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done,
    output reg [7:0] out_byte
); 
    
    parameter NONE  = 3'd0,
              START = 3'd1,
              DATA  = 3'd2,
              STOP  = 3'd3,
              WAIT  = 3'd4;
    reg [2:0] state, next;
    reg [3:0] count = 4'd0;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            NONE  : next = in ? NONE : START;
            START : next = DATA;
            DATA  : begin
                if (count >= 4'd8 && in) begin
                    next = STOP;
                end
                else if (count < 4'd8) begin
                    next = DATA;
                end
                else begin
                    next = WAIT;
                end
            end
            STOP  : next = in ? NONE : START;
            WAIT  : next = in ? NONE : WAIT;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= NONE;
            count <= 4'd0;
        end
        else begin
            state <= next;
            if (next == DATA) begin
                count <= count + 4'd1;
            end
            else begin
                count <= 4'd0;
            end
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'd0;
        end
        else begin
            done <= (next == STOP);
            out_byte[count] <= in;
        end
    end

endmodule
