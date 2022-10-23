/*=============================================================================
#
# Author: mengguodong Email: 823300630@qq.com
#
# Personal Website: guodongblog.com
#
# Last modified: 2022-10-23 12:18
#
# Filename: sync_w2r.v
#
# Description: 
#
=============================================================================*/
module SYNC_W2R #( parameter ADDRSIZE = 4 )(
    input   wire                              i_rclk                                       ,
    input   wire                              i_rrst_n                                     ,
    input   wire    [ADDRSIZE   : 0]          i_wptr                                       ,
    output  reg     [ADDRSIZE   : 0]          o_wptr_sync                                  
);
reg [ADDRSIZE :0] wptr_ff;
always @ (posedge i_rclk or negedge i_rrst_n)begin
    if(i_rrst_n == 1'b0)begin 
        wptr_ff <= 0;
        o_wptr_sync <= 0;
    end
    else begin 
        wptr_ff <= i_wptr;
        o_wptr_sync <= wptr_ff;
    end
end
endmodule
