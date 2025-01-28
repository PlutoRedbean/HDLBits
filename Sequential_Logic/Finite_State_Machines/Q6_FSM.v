module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output reg z);
    
    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100,
              F = 3'b101;

    reg [2:0] state, next;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A : next = w ? A : B;
            B : next = w ? D : C;
            C : next = w ? D : E;
            D : next = w ? A : F;
            E : next = w ? D : E;
            F : next = w ? D : C;
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
