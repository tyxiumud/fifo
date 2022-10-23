/*=============================================================================
#
# Author: mengguodong Email: 823300630@qq.com
#
# Personal Website: guodongblog.com
#
# Last modified: 2022-10-23 13:41
#
# Filename: wptr_full.v
#
# Description: 
#
=============================================================================*/
module WPTR_FULL #(parameter ADDRSIZE = 4)(
    input   wire    [ADDRSIZE  : 0]          i_rptr_sync                                  ,
    input   wire                             i_w_en                                       ,
    input   wire                             i_wclk                                       ,
    input   wire                             i_wrst_n                                     ,
    output  reg                              o_wfull_flag                                 ,
    output  wire    [ADDRSIZE-1: 0]          o_waddr                                      ,
    output  reg     [ADDRSIZE  : 0]          o_wptr
);
//*************************************************\
//define parameter and intennal singles
//*************************************************/
reg [ADDRSIZE:0] wbin;
wire [ADDRSIZE:0] w_gray_next;
wire [ADDRSIZE:0] w_bin_next;
wire wfull_flag;
//*************************************************\
//main code
//*************************************************/
always @ (posedge i_wclk or negedge i_wrst_n)begin
    if(i_wrst_n == 1'b0)begin
        wbin <= 0;
        o_wptr <= 0;
    end 
    else begin 
        wbin <= w_bin_next;
        o_wptr <= w_gray_next;
    end
end
assign o_waddr = wbin[ADDRSIZE-1:0];
assign w_bin_next = wbin + ((i_w_en == 1'b1) && (o_wfull_flag == 1'b0));
assign w_gray_next = (w_bin_next >> 1) ^ w_bin_next;
//FIFO full_flag 
assign wfull_flag = (w_gray_next == {~i_rptr_sync[ADDRSIZE:ADDRSIZE-1],i_rptr_sync[ADDRSIZE-2:0]});
always @ (posedge i_wclk or negedge i_wrst_n)begin
    if(i_wrst_n == 1'b0)
        o_wfull_flag <= 1'b0;
    else 
        o_wfull_flag <= wfull_flag;
end
endmodule
