module top_module (
    input clk   ,
    input resetn,    // active-low synchronous reset
    input x     ,
    input y     ,
    output reg f,
    output reg g
);

    parameter A      = 3'd0,
              START  = 3'd1,
              FUNC0  = 3'd2,
              FUNC1  = 3'd3,
              FUNC10 = 3'd4,
              DONE   = 3'd5,
              HIGH   = 3'd6,
              LOW    = 3'd7;

    reg [2:0] state, next;
    reg [1:0] count      ;
    reg       check      ;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A      : next = resetn ? START : A;
            START  : next = FUNC0             ;
            FUNC0  : next = x ? FUNC1 : FUNC0 ;
            FUNC1  : next = x ? FUNC1 : FUNC10;
            FUNC10 : next = x ? DONE  : FUNC0 ;
            HIGH   : next = HIGH              ;
            LOW    : next = LOW               ;
            DONE   : begin
                if (check) begin
                    next = HIGH;
                end
                else if (count == 2'd2 & y) begin
                    next = HIGH;
                end
                else if (count < 2'd2) begin
                    next = DONE;
                end
                else begin
                    next = LOW;
                end
            end
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
            count <= 1'd0;
            check <= 1'd0;
        end
        else begin
            state <= next;
            if (next == DONE & count < 2'd2) begin
                count <= count + 1'd1;
            end
            if (state == DONE & count < 2'd2 & ~check) begin
                check <= y;
            end
        end
    end


    // Output logic
    always @(posedge clk) begin
        if (~resetn) begin
            f <= 1'b0;
            g <= 1'b0;
        end
        else begin
            f <= (next == START);
            g <= (next == DONE | next == HIGH);
        end
    end

endmodule
