module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z
); 

    reg [7:0] Q;
    // reg result;

    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S};
        end
        // result <= Q[ {A, B, C} ];
    end

    assign Z = Q[ {A, B, C} ];

endmodule
