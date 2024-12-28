module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); 
    reg [3:0] num1, num2, num3; //num3 num2 num1
    assign c_enable[0] = 1'b1;
    bcdcount counter0 (clk, reset, c_enable[0], num1);
    bcdcount counter1 (clk, reset, c_enable[1], num2);
    bcdcount counter2 (clk, reset, c_enable[2], num3);
    assign c_enable[1] = (num1 == 4'd9) ? 1'b1 : 1'b0;  //{num3 num2 9}的时候 num2 + 1
    assign c_enable[2] = (num2 == 4'd9 && num1 == 4'd9) ? 1'b1 : 1'b0;  //{num3 9 9}的时候 num3 + 1
    assign OneHertz = (num3 == 4'd9 && num2 == 4'd9 && num1 == 4'd9) ? 1'b1 : 1'b0; //{9 9 9}的时候 OneHertz = 1
endmodule
