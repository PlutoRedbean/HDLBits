module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q
);

    reg [255:0] result;
    reg [3:0] num;
    reg [7:0] i;

    always @(posedge clk) begin
        if (load) begin
            result <= data;
        end
        else begin
            for (i = 0; i < 255; i = i + 8'd1) begin
                num = 4'd0;
                if (i == 0) begin
                    num = q[255] + q[240] + q[241] + q[15] + q[1] + q[31] + q[16] + q[17];
                end
                else if (i == 15) begin
                    num = q[254] + q[255] + q[240] + q[14] + q[0] + q[30] + q[31] + q[16];
                end
                else if (i == 240) begin
                    num = q[239] + q[224] + q[225] + q[255] + q[241] + q[15] + q[0] + q[1];
                end
                else if( ( i % 8'd16 ) == 0 ) begin
                    num = q[ i - 8'd1 ] ? num + 4'd1 : num;
                    num = q[ i + 8'd1 ] ? num + 4'd1 : num;
                    num = q[ i + 8'd16] ? num + 4'd1 : num;
                    num = q[ i - 8'd16] ? num + 4'd1 : num;
                    num = q[ i + 8'd15] ? num + 4'd1 : num;
                    num = q[ i + 8'd31] ? num + 4'd1 : num;
                    num = q[ i + 8'd17] ? num + 4'd1 : num;
                    num = q[ i - 8'd15] ? num + 4'd1 : num;
                end
                else if( ( (i + 8'd1) % 8'd16 ) == 0 ) begin
                    num = q[ i - 8'd1 ] ? num + 4'd1 : num;
                    num = q[ i + 8'd1 ] ? num + 4'd1 : num;
                    num = q[ i + 8'd16] ? num + 4'd1 : num;
                    num = q[ i - 8'd16] ? num + 4'd1 : num;
                    num = q[ i + 8'd15] ? num + 4'd1 : num;
                    num = q[ i - 8'd17] ? num + 4'd1 : num;
                    num = q[ i - 8'd31] ? num + 4'd1 : num;
                    num = q[ i - 8'd15] ? num + 4'd1 : num;
                end
                else begin
                    num = q[ i - 8'd1 ] ? num + 4'd1 : num;
                    num = q[ i + 8'd1 ] ? num + 4'd1 : num;
                    num = q[ i + 8'd16] ? num + 4'd1 : num;
                    num = q[ i - 8'd16] ? num + 4'd1 : num;
                    num = q[ i + 8'd17] ? num + 4'd1 : num;
                    num = q[ i - 8'd15] ? num + 4'd1 : num;
                    num = q[ i + 8'd15] ? num + 4'd1 : num;
                    num = q[ i - 8'd17] ? num + 4'd1 : num;
                end
                if (num <= 1 || num >= 4 ) begin
                    result[i] <= 1'd0;
                end
                else if (num == 3) begin
                    result[i] <= 1'd1;
                end
                else if (num == 2) begin
                    result[i] <= result[i];
                end
            end
            num = 4'd0;
            num = q[ 254 ] ? num + 4'd1 : num;
            num = q[ 224 ] ? num + 4'd1 : num;
            num = q[  16 ] ? num + 4'd1 : num;
            num = q[  15 ] ? num + 4'd1 : num;
            num = q[  17 ] ? num + 4'd1 : num;
            num = q[ 239 ] ? num + 4'd1 : num;
            num = q[ 238 ] ? num + 4'd1 : num;
            num = q[ 240 ] ? num + 4'd1 : num;
            if (num <= 1 || num >= 4 ) begin
                result[255] <= 1'd0;
            end
            else if (num == 3) begin
                result[255] <= 1'd1;
            end
            else if (num == 2) begin
                result[255] <= result[255];
            end
        end
    end

    assign q = result;

endmodule
