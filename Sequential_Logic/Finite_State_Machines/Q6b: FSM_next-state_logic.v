module top_module (
    input [3:1] y,
    input w,
    output reg Y2);

    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100,
              F = 3'b101;

    reg [2:0] state, next;
    
    // State transition logic (combinational)
    always @(*) begin
        case (y)
            A : Y2 = w ? 1'b0 : 1'b0;
            B : Y2 = w ? 1'b1 : 1'b1;
            C : Y2 = w ? 1'b1 : 1'b0;
            D : Y2 = w ? 1'b0 : 1'b0;
            E : Y2 = w ? 1'b1 : 1'b0;
            F : Y2 = w ? 1'b1 : 1'b1;
            // A : next = w ? A : B;
            // B : next = w ? D : C;
            // C : next = w ? D : E;
            // D : next = w ? A : F;
            // E : next = w ? D : E;
            // F : next = w ? D : C;
            default : Y2 = 1'b0;
        endcase
    end

    // State flip-flops (sequential)

    // Output logic

endmodule
