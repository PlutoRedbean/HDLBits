module top_module (
    input               clk,
    input            resetn,   // active-low synchronous reset
    input      [3:1]      r,   // request
    output reg [3:1]      g    // grant
);

    parameter A = 2'd0,
              B = 2'd1,
              C = 2'd2,
              D = 2'd3;

    reg [1:0] state, next;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A : begin
                if      (r[1]) next = B;
                else if (r[2]) next = C;
                else if (r[3]) next = D;
                else           next = A;
            end
            B : next = r[1] ? B : A;
            C : next = r[2] ? C : A;
            D : next = r[3] ? D : A;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (~resetn) begin
            g <= 3'b000;
        end
        else begin
            g[1] <= (next == B);
            g[2] <= (next == C);
            g[3] <= (next == D);
        end
    end

endmodule
