module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4);

    parameter A = 6'b000001,
              B = 6'b000010,
              C = 6'b000100,
              D = 6'b001000,
              E = 6'b010000,
              F = 6'b100000;

    reg [5:0] state, next;
    
    // State transition logic (combinational)
    // always @(*) begin
    //     case (y)
    //         A : Y2 = w ? 1'b0 : 1'b1;
    //         B : Y2 = w ? 1'b0 : 1'b0;
    //         C : Y2 = w ? 1'b0 : 1'b0;
    //         D : Y2 = w ? 1'b0 : 1'b0;
    //         E : Y2 = w ? 1'b0 : 1'b0;
    //         F : Y2 = w ? 1'b0 : 1'b0;
    //         default : Y2 = 1'b0;
    //     endcase
    //     case (y)
    //         A : Y4 = w ? 1'b0 : 1'b0;
    //         B : Y4 = w ? 1'b1 : 1'b0;
    //         C : Y4 = w ? 1'b1 : 1'b0;
    //         D : Y4 = w ? 1'b0 : 1'b0;
    //         E : Y4 = w ? 1'b1 : 1'b0;
    //         F : Y4 = w ? 1'b1 : 1'b0;
    //         default : Y4 = 1'b0;
    //     endcase
    //     // A : next = w ? A : B;
    //     // B : next = w ? D : C;
    //     // C : next = w ? D : E;
    //     // D : next = w ? A : F;
    //     // E : next = w ? D : E;
    //     // F : next = w ? D : C;
    // end
    always @(*) begin
        Y2 = (y[1] & ~w);
        Y4 = ( (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w) );
    end
    // State flip-flops (sequential)

    // Output logic

endmodule
