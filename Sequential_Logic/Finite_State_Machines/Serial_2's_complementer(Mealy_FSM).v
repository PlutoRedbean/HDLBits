module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 

    parameter A = 2'b01,
              B = 2'b10;

    reg [1:0] state, next;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A : next = x ? B : A;
            B : next = B;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end

    // Output logic
    always @(*) begin
        if (state == A) begin
            z = x;
        end
        else begin
            z = ~x;
        end
    end

endmodule
