/*=============================================================================
#
# Author: mengguodong Email: 823300630@qq.com
#
# Personal Website: guodongblog.com
#
# Last modified: 2022-10-23 12:22
#
# Filename: rptr_empty.v
#
# Description: 
#
=============================================================================*/
module RPTR_EMPTY #(parameter ADDRSIZE = 4)(
    input   wire    [ADDRSIZE  : 0]          i_wptr_sync                                  ,
    input   wire                             i_r_en                                       ,
    input   wire                             i_rclk                                       ,
    input   wire                             i_rrst_n                                     ,
    output  reg                              o_rempty_flag                                ,
    output  wire    [ADDRSIZE-1: 0]          o_raddr                                      ,
    output  reg     [ADDRSIZE  : 0]          o_rptr
);
//*************************************************\
//define parameter and intennal singles
//*************************************************/
reg [ADDRSIZE:0] rbin;
wire [ADDRSIZE:0] r_gray_next;
wire [ADDRSIZE:0] r_bin_next;
wire rempty_flag;
//*************************************************\
//main code
//*************************************************/
always @ (posedge i_rclk or negedge i_rrst_n)begin
    if(i_rrst_n == 1'b0)begin
        rbin <= 0;
        o_rptr <= 0;
    end 
    else begin 
        rbin <= r_bin_next;
        o_rptr <= r_gray_next;
    end
end

assign o_raddr = rbin[ADDRSIZE-1:0];
assign r_bin_next = rbin + ((i_r_en == 1'b1) && (o_rempty_flag == 1'b0));
assign r_gray_next = (r_bin_next >> 1) ^ r_bin_next;
//FIFO empty_flag
assign rempty_flag = (r_gray_next == i_wptr_sync);
always @ (posedge i_rclk or negedge i_rrst_n) begin
    if(i_rrst_n == 1'b0)
        o_rempty_flag <= 1'b1;
    else 
        o_rempty_flag <= rempty_flag;
end
endmodule
