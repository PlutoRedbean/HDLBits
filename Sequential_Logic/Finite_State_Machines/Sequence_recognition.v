module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    parameter LEADING_ZERO = 3'd0,
              ONE          = 3'd1,
              TAILING_ZERO = 3'd2;

    reg [2:0] state, next;
    reg [2:0] count;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            LEADING_ZERO : next = in ? ONE : LEADING_ZERO;
            ONE          : next = in ? ONE : TAILING_ZERO;
            TAILING_ZERO : next = in ? ONE : LEADING_ZERO;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= LEADING_ZERO;
            count <= 3'd0;
        end
        else begin
            state <= next;
            if (next == ONE & count < 3'd7) begin
                count <= count + 1'd1;
            end
            else if (next == ONE & count == 3'd7) begin
                count <= 3'd7;
            end
            else begin
                count <= 3'd0;
            end
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'd0;
            flag <= 1'd0;
            err  <= 1'd0;
        end
        else begin
            disc <= (next == TAILING_ZERO & count == 3'd5);
            flag <= (next == TAILING_ZERO & count == 3'd6);
            err  <= (next == ONE          & count >= 3'd6);
        end
    end
endmodule
