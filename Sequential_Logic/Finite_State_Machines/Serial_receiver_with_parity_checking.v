module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done,
    output reg [7:0] out_byte
); 
    
    parameter NONE   = 3'd0,
              START  = 3'd1,
              DATA   = 3'd2,
              STOP   = 3'd3,
              WAIT   = 3'd4,
              PARITY = 3'd5;
    reg [3:0] count  = 4'd0;
    reg [2:0] state, next;
    reg parity_check;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            NONE   : next = in ? NONE : START;
            START  : next = DATA;
            DATA   : next = (count >= 4'd8) ? PARITY : DATA;
            PARITY : next = in ? STOP : WAIT;
            STOP   : next = in ? NONE : START;
            WAIT   : next = in ? NONE : WAIT;
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
    parity u0_parity(
        .clk( clk ),
        .reset( reset | (next != DATA & next != PARITY) ),
        .in( in & (next == DATA | next == PARITY) ),
        .odd( parity_check )
    );

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'd0;
        end
        else begin
            done <= (next == STOP & parity_check);
            if (next == DATA) begin
                out_byte[count] <= in;
            end
        end
    end

endmodule
