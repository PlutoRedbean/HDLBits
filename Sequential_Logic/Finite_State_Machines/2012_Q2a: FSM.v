module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output reg z
);

    parameter A = 3'd0,
              B = 3'd1,
              C = 3'd2,
              D = 3'd3,
              E = 3'd4,
              F = 3'd5;

    reg [2:0] state, next;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A : next = w ? B : A;
            B : next = w ? C : D;
            C : next = w ? E : D;
            D : next = w ? F : A;
            E : next = w ? E : D;
            F : next = w ? C : D;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            z <= 1'd0;
        end
        else begin
            z <= (next == E | next == F);
        end
    end

endmodule
