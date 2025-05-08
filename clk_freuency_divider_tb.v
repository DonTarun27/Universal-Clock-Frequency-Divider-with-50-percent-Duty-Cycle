`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dhavala Tarun Kumar
// 
// Create Date: 06.05.2025 11:40:54
// Design Name: 
// Module Name: clk_freuency_divider_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
