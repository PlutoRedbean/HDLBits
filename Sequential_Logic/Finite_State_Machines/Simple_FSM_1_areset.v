module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output reg out);//  

    parameter A = 1'b0, B = 1'b1; 
    reg state = A, next_state = A;

    always @(*) begin    // This is a combinational always block
        case (state)
            A : next_state = in ? A : B;
            B : next_state = in ? B : A;
            default : next_state = state;
        endcase
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        if (areset) begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            out <= 1'd1;
        end
        else begin
            out <= (next_state == B) ? 1'd1 : 1'd0;
        end
    end

endmodule
