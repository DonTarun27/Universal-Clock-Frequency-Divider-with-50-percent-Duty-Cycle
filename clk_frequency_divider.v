`timescale 1ns / 1ps
module clk_frequency_divider
    #(parameter N = 5)
    (input clk, rst,
    output clk_out);

    localparam size = $clog2(N);
    genvar i;
    reg [size-1:0] pos_cnt;

    generate
    case(N%2)
    0:
    begin: Even_Number
        if(N==2**size)
        begin: Base2_Exponential
            always@(posedge clk or posedge rst) //Synchronous
            begin
                if(rst) pos_cnt <= 0;
                else pos_cnt <= pos_cnt+1;
            end
            assign clk_out = pos_cnt[size-1];
            /*
            always@(posedge clk or posedge rst) //Asynchronous
            begin
                if(rst) pos_cnt[0] <= 0;
                else pos_cnt[0] <= ~pos_cnt[0];
            end
            for(i=0; i<size-1; i=i+1)
            begin
                always@(posedge pos_cnt[i] or posedge rst)
                begin
                    if(rst) pos_cnt[i+1] <= 0;
                    else pos_cnt[i+1] <= ~pos_cnt[i+1];
                end
            end
            assign clk_out = pos_cnt[size-1];
            */
        end
        else
        begin: Non_Base2_Exponential
            always@(posedge clk or posedge rst)
            begin
                if(rst) pos_cnt <= 0;
                else if(pos_cnt==N) pos_cnt <= 1;
                else pos_cnt <= pos_cnt+1;
            end
            assign clk_out = pos_cnt[size-1];
        end
    end
    default:
    begin: Odd_Number
        reg [size-1:0] neg_cnt;
        reg clk_out_prev;
        always@(posedge clk) clk_out_prev <= clk_out;
        always@(posedge clk or posedge rst)
        begin
            if(rst|pos_cnt==N-1) pos_cnt <= 0;
            else pos_cnt <= pos_cnt+1;
        end
        always@(negedge clk or posedge rst)
        begin
            if(rst) neg_cnt <= 0;
            else if(neg_cnt==N) neg_cnt <= 1;
            else neg_cnt <= neg_cnt+1;
        end
        assign clk_out = (pos_cnt==(N+1)/2)?1:((neg_cnt==N)?0:clk_out_prev);
    end
    endcase
    endgenerate
endmodule
