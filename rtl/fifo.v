/*=============================================================================
#
# Author: mengguodong Email: 823300630@qq.com
#
# Personal Website: guodongblog.com
#
# Last modified: 2022-10-23 10:55
#
# Filename: fifo.v
#
# Description: 
#
=============================================================================*/
module FIFO #(  parameter DATASIZE = 8,
                parameter ADDRSIZE = 4)(
    input   wire    [DATASIZE  -1: 0]       i_wdata                                      ,
    input   wire                            i_w_en                                       ,
    input   wire                            i_wclk                                       ,
    input   wire                            i_wrst_n                                     ,
    input   wire                            i_r_en                                       ,
    input   wire                            i_rclk                                       ,
    input   wire                            i_rrst_n                                     ,
    output  wire    [DATASIZE  -1: 0]       o_rdata                                      ,
    output  wire                            o_wfull_flag                                 ,
    output  wire                            o_rempty_flag                                     
);
//*************************************************\
//define parameter and intennal singles
//*************************************************/
wire [ADDRSIZE: 0] wptr;
wire [ADDRSIZE: 0] wptr_sync;
wire [ADDRSIZE-1: 0] waddr;
wire [ADDRSIZE: 0] rptr;
wire [ADDRSIZE: 0] rptr_sync;
wire [ADDRSIZE-1: 0] raddr;
wire rrst_n;
wire wrst_n;
//*************************************************\
//main code
//*************************************************/

SYNC_RST U_SYNC_RST_0(
    .i_clk                                                 (i_rclk                                                ),
    .i_rst_n                                               (i_rrst_n                                              ),
    .o_rst_n                                               (rrst_n                                                )
);


SYNC_RST U_SYNC_RST_1(
    .i_clk                                                 (i_wclk                                                ),
    .i_rst_n                                               (i_wrst_n                                              ),
    .o_rst_n                                               (wrst_n                                                )
);

FIFO_MEM #(
    .DATASIZE                                              (8                                                     ),
    .ADDRSIZE                                              (4                                                     ))
U_FIFO_MEM_0(
    .i_wdata                                               (i_wdata                                               ),
    .i_waddr                                               (waddr                                                 ),
    .i_raddr                                               (raddr                                                 ),
    .i_w_en                                                (i_w_en                                                ),
    .i_wfull_flag                                          (o_wfull_flag                                          ),
    .i_wclk                                                (i_wclk                                                ),
    .o_rdata                                               (o_rdata                                               )
);

WPTR_FULL #(
    .ADDRSIZE                                              (4                                                     ))
U_WPTR_FULL_0(
    .i_rptr_sync                                           (rptr_sync                                             ),
    .i_w_en                                                (i_w_en                                                ),
    .i_wclk                                                (i_wclk                                                ),
    .i_wrst_n                                              (wrst_n                                                ),
    .o_wfull_flag                                          (o_wfull_flag                                          ),
    .o_waddr                                               (waddr                                                 ),
    .o_wptr                                                (wptr                                                  )
);

SYNC_W2R #(
    .ADDRSIZE                                              (4                                                     ))
U_SYNC_W2R_0(
    .i_rclk                                                (i_rclk                                                ),
    .i_rrst_n                                              (rrst_n                                                ),
    .i_wptr                                                (wptr                                                  ),
    .o_wptr_sync                                           (wptr_sync                                             )
);

SYNC_R2W #(
    .ADDRSIZE                                              (4                                                     ))
U_SYNC_R2W_0(
    .i_wclk                                                (i_wclk                                                ),
    .i_wrst_n                                              (wrst_n                                                ),
    .i_rptr                                                (rptr                                                  ),
    .o_rptr_sync                                           (rptr_sync                                             )
);

RPTR_EMPTY #(
    .ADDRSIZE                                              (4                                                     ))
U_RPTR_EMPTY_0(
    .i_wptr_sync                                           (wptr_sync                                             ),
    .i_r_en                                                (i_r_en                                                ),
    .i_rclk                                                (i_rclk                                                ),
    .i_rrst_n                                              (rrst_n                                                ),
    .o_rempty_flag                                         (o_rempty_flag                                         ),
    .o_raddr                                               (raddr                                                 ),
    .o_rptr                                                (rptr                                                  )
);

endmodule
