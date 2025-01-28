module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output reg z
);

    parameter S0 = 2'd0,
              S1 = 2'd1,
              S2 = 2'd2;

    reg [1:0] state, next;

    initial begin
        state = S0;
    end
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0 : next = x ? S1 : S0;
            S1 : next = x ? S1 : S2;
            S2 : next = x ? S1 : S0;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(negedge aresetn, posedge clk) begin
        if (~aresetn) begin
            state <= S0;
        end
        else begin
            state <= next;
        end
    end

    // Output logic
    always @(*) begin
        z = (state == S2 & x == 1'd1);
    end

endmodule
