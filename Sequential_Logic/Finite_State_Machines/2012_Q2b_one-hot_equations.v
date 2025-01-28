module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

    parameter A = 6'b000001,
              B = 6'b000010,
              C = 6'b000100,
              D = 6'b001000,
              E = 6'b010000,
              F = 6'b100000;

    reg [2:0] state, next;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            // A : next = w ? B : A;
            // B : next = w ? C : D;
            // C : next = w ? E : D;
            // D : next = w ? F : A;
            // E : next = w ? E : D;
            // F : next = w ? C : D;
            default : next = state;
        endcase
    end

    // State flip-flops (sequential)
    // always @(posedge clk) begin
    //     if (reset) begin
    //         state <= A;
    //     end
    //     else begin
    //         state <= next;
    //     end
    // end

    // Output logic
    always @(*) begin
        Y1 <= ( (y[0] &  w) );
        Y3 <= ( (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w) );
    end

endmodule
