/*=============================================================================
#
# Author: mengguodong Email: 823300630@qq.com
#
# Personal Website: guodongblog.com
#
# Last modified:	2022-10-23 16:15
#
# Filename:		tb_fifo.v
#
# Description: 
#
=============================================================================*/
module TB_FIFO();
reg i_wclk;
reg i_wrst_n;
reg i_rclk;
reg i_rrst_n;
reg i_w_en;
reg wen_flag;
reg ren_flag;
reg i_r_en;
reg [7:0] i_wdata;
reg [7:0] w_data;

initial begin
    i_wclk = 1'b0;
    i_rclk = 1'b0;
    i_rrst_n = 1'b0;
    i_wrst_n = 1'b0;
    i_wdata = 8'd0;
    i_w_en = 1'b0;
    i_r_en = 1'b0;
    #20;
    i_rrst_n = 1'b1;
    i_wrst_n = 1'b1;
    #100;
    i_w_en = 1'b1;
    #1000;
    i_r_en = 1'b1;
    i_w_en = 1'b0;
    #1000;
    i_w_en = 1'b0;
    i_r_en = 1'b0;
    #1000;
    i_w_en = 1'b1;
    i_r_en = 1'b1;
    #1000;
    i_w_en = 1'b0;
    i_r_en = 1'b0;
    $finish;
end
always #5 i_wclk = ~i_wclk;
always #10 i_rclk = ~i_rclk;

FIFO #(
    .DATASIZE                       ( 8                             ),
    .ADDRSIZE                       ( 4                             ))
U_FIFO_0(
    .i_wdata                                               (w_data                                                ),
    .i_w_en                                                (wen_flag                                              ),
    .i_wclk                                                (i_wclk                                                ),
    .i_wrst_n                                              (i_wrst_n                                              ),
    .i_r_en                                                (ren_flag                                              ),
    .i_rclk                                                (i_rclk                                                ),
    .i_rrst_n                                              (i_rrst_n                                              ),
    .o_rdata                                               (o_rdata                                               ),
    .o_wfull_flag                                          (o_wfull_flag                                          ),
    .o_rempty_flag                                         (o_rempty_flag                                         )
);
always @ (posedge i_wclk or negedge i_wrst_n)begin 
    if(i_wrst_n == 1'b0)
        w_data <= 8'd0;
    else if(wen_flag == 1'b1)
        w_data <= w_data + 1'b1;
end

always @ (posedge i_wclk or negedge i_wrst_n)begin 
    if(i_wrst_n == 1'b0)
        wen_flag <= 1'b0;
    else if(i_w_en == 1'b1)
        wen_flag <= 1'b1;
    else 
        wen_flag <= 1'b0;
end

always @ (posedge i_rclk or negedge i_rrst_n)begin 
    if(i_rrst_n == 1'b0)
        ren_flag <= 1'b0;
    else if(i_r_en == 1'b1)
        ren_flag <= 1'b1;
    else 
        ren_flag <= 1'b0;
end


endmodule
