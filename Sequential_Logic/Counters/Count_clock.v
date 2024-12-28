module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    // reg cs_s, cs_m, cm_m, cm_h, ch_h;
    reg [3:0] s1, s2, m1, m2, h1, h2;
    reg PM;
    reg roll;

    always @(posedge clk) begin
        if (reset) begin
            {s2, s1} <= 8'h00;
            {m2, m1} <= 8'h00;
            {h2, h1} <= 8'h12;
            PM <= 1'd0;
        end
        else begin
            if (s1 < 4'd9 && ena) begin
                s1 <= s1 + 4'd1;
            end
            else if(s1 >= 4'd9 && ena) begin
                s1 <= 4'd0;
            end
            if (s2 < 4'd5 && s1 >= 4'd9 && ena) begin
                s2 <= s2 + 4'd1;
            end
            else if(s2 >= 4'd5 && s1 >= 4'd9 && ena) begin
                s2 <= 4'd0;
            end
            if (m1 < 4'd9 && s2 >= 4'd5 && s1 >= 4'd9 && ena) begin
                m1 <= m1 + 4'd1;
            end
            else if(m1 >= 4'd9 && s2 >= 4'd5 && s1 >= 4'd9 && ena) begin
                m1 <= 4'd0;
            end
            if (m2 < 4'd5 && m1 >= 4'd9 && s2 >= 4'd5 && s1 >= 4'd9 && ena) begin
                m2 <= m2 + 4'd1;
            end
            else if(m2 >= 4'd5 && m1 >= 4'd9 && s2 >= 4'd5 && s1 >= 4'd9 && ena) begin
                m2 <= 4'd0;
            end

            if ( {h2, h1} < 8'h12 ) begin
                if (h1 < 4'd9 && m2 >= 4'd5 && m1 >= 4'd9 && s2 >= 4'd5 && s1 >= 4'd9 && ena) begin
                    h1 <= h1 + 4'd1;
                    if ({h2, h1} == 8'h11) begin
                        PM <= PM + 1'd1;
                    end
                end
                else if(h1 >= 4'd9 && m2 >= 4'd5 && m1 >= 4'd9 && s2 >= 4'd5 && s1 >= 4'd9 && ena) begin
                    h1 <= 4'd0;
                    h2 <= h2 + 4'd1;
                end
            end
            else if( {h2, h1} >= 8'h12 && m2 >= 4'd5 && m1 >= 4'd9 && s2 >= 4'd5 && s1 >= 4'd9 ) begin
                {h2, h1} <= 8'h01;
            end
        end
    end

    assign pm = PM;
    assign ss = {s2, s1};
    assign mm = {m2, m1};
    assign hh = {h2, h1};
endmodule

