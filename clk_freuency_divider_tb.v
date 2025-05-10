`timescale 1ns / 1ps
module clk_freuency_divider_tb;
    reg clk, rst;
    wire clk_out;
    clk_frequency_divider #(.N(5)) cfd1(.clk(clk),.rst(rst),.clk_out(clk_out));
    initial
    begin
        clk=1'b0;
        #4 rst=1'b1;
        #8 rst=1'b0;
        #300 $stop;
    end
    always #5 clk=~clk;
endmodule
