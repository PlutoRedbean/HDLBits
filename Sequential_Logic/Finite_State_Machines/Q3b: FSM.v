module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output reg z
);

    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100;

    reg [2:0] state, next;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A : next = x ? B : A;
            B : next = x ? E : B;
            C : next = x ? B : C;
            D : next = x ? C : B;
            E : next = x ? E : D;
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
            z <= (next == D || next == E);
        end
    end

endmodule
