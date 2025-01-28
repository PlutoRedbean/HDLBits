module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output reg z
);

    parameter A = 1'd0,
              B = 1'd1;

    reg state, next;
    reg [1:0] clk_count;
    reg [1:0] sig_count;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A : next = s ? B : A;
            B : next = B;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            clk_count <= 2'd0;
            sig_count <= 2'd0;
        end
        else begin
            state <= next;
            if (next == B) clk_count <= clk_count + 1'd1;
            if (clk_count == 2'd3) begin
                sig_count <= 2'd0;
            end
            else begin
                sig_count <= w ? (sig_count + 1'd1) : sig_count;
            end
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            z <= 1'd0;
        end
        else begin
            z <= (sig_count == 2'd2);
        end
    end

endmodule
