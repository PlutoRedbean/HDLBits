module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    parameter A = 3'd0, B = 3'd1, B_d = 3'd2, C = 3'd3, C_d = 3'd4, D = 3'd5;
    reg [2:0] state, next;

    always @(*) begin
        case (state)
            A : begin
                case (s)
                    3'b000 : next = A;
                    3'b001 : next = B;
                    3'b011 : next = C;
                    3'b111 : next = D;
                    default : next = 1'bx;
                endcase
            end
            B : begin
                case (s)
                    3'b000 : next = A;
                    3'b001 : next = B;
                    3'b011 : next = C;
                    3'b111 : next = D;
                    default : next = 1'bx;
                endcase
            end
            B_d : begin
                case (s)
                    3'b000 : next = A;
                    3'b001 : next = B_d;
                    3'b011 : next = C;
                    3'b111 : next = D;
                    default : next = 1'bx;
                endcase
            end
            C : case (s)
                    3'b000 : next = A;
                    3'b001 : next = B_d;
                    3'b011 : next = C;
                    3'b111 : next = D;
                    default : next = 1'bx;
                endcase
            C_d : begin
                case (s)
                    3'b000 : next = A;
                    3'b001 : next = B_d;
                    3'b011 : next = C_d;
                    3'b111 : next = D;
                    default : next = 1'bx;
                endcase
            end
            D : case (s)
                    3'b000 : next = A;
                    3'b001 : next = B_d;
                    3'b011 : next = C_d;
                    3'b111 : next = D;
                    default : next = 1'bx;
                endcase
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            dfr <= 1'd1;
            fr1 <= 1'd1;
            fr2 <= 1'd1;
            fr3 <= 1'd1;
        end
        else begin
            dfr <= ( next == A | next == B_d | next == C_d );
            fr1 <= ( next == A | next == B | next == B_d | next == C | next == C_d );
            fr2 <= ( next == A | next == B | next == B_d );
            fr3 <= ( next == A );
        end
    end

    /*parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
    reg [1:0] previous_state, current_state, next_state;
    reg delta_fr;

    always @(*) begin
        case (current_state)
            A : begin
                case (s)
                    3'b000 : next_state <= A;
                    3'b001 : next_state <= B;
                    3'b011 : next_state <= C;
                    3'b111 : next_state <= D;
                    default : next_state <= 1'bx;
                endcase
            end
            B : begin
                case (s)
                    3'b000 : next_state <= A;
                    3'b001 : next_state <= B;
                    3'b011 : next_state <= C;
                    3'b111 : next_state <= D;
                    default : next_state <= 1'bx;
                endcase
            end
            C : case (s)
                    3'b000 : next_state <= A;
                    3'b001 : next_state <= B;
                    3'b011 : next_state <= C;
                    3'b111 : next_state <= D;
                    default : next_state <= 1'bx;
                endcase
            D : case (s)
                    3'b000 : next_state <= A;
                    3'b001 : next_state <= B;
                    3'b011 : next_state <= C;
                    3'b111 : next_state <= D;
                    default : next_state <= 1'bx;
                endcase
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
            previous_state <= current_state;
            // delta_fr <= ( previous_state >= current_state ) ? 1'b1 : 1'b0;
        end
    end

    assign dfr = ( current_state == A | ( previous_state > current_state ) );
    assign fr1 = ( current_state == A | current_state == B | current_state == C );
    assign fr2 = ( current_state == A | current_state == B );
    assign fr3 = ( current_state == A );*/

endmodule
