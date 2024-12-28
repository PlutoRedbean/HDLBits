module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out
); //

    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] next;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        case (state)
            A : next = in ? B : A;
            B : next = in ? B : C;
            C : next = in ? D : A;
            D : next = in ? B : C;
            default : ;
        endcase
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign next_state = next;
    assign out = ( state == D );

endmodule
