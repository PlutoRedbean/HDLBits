module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2
);

    reg [9:0] next;
    parameter S0 = 10'b0000000001,
              S1 = 10'b0000000010,
              S2 = 10'b0000000100,
              S3 = 10'b0000001000,
              S4 = 10'b0000010000,
              S5 = 10'b0000100000,
              S6 = 10'b0001000000,
              S7 = 10'b0010000000,
              S8 = 10'b0100000000,
              S9 = 10'b1000000000;

    always @(*) begin
        next = 10'd0;
        next[0] = ~in &  ( state[0] | state[1] | state[2] | state[3] | state[4] | state[7] | state[8] | state[9]);
        next[1] =  in &  ( state[0] | state[8] | state[9] );
        next[2] =  in &  ( state[1]                       );
        next[3] =  in &  ( state[2]                       );
        next[4] =  in &  ( state[3]                       );
        next[5] =  in &  ( state[4]                       );
        next[6] =  in &  ( state[5]                       );
        next[7] =  in &  ( state[6] | state[7]            );
        next[8] = ~in &  ( state[5]                       );
        next[9] = ~in &  ( state[6]                       );
    end

    assign next_state = next;
    assign out1 = (state[8] | state[9]);
    assign out2 = (state[7] | state[9]);

endmodule
