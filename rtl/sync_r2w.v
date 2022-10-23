/*=============================================================================
#
# Author: mengguodong Email: 823300630@qq.com
#
# Personal Website: guodongblog.com
#
# Last modified: 2022-10-23 12:05
#
# Filename: sync_r2w.v
#
# Description: 
#
=============================================================================*/
module SYNC_R2W #( parameter ADDRSIZE = 4 )(
    input   wire                              i_wclk                                       ,
    input   wire                              i_wrst_n                                     ,
    input   wire    [ADDRSIZE   : 0]          i_rptr                                       ,
    output  reg     [ADDRSIZE   : 0]          o_rptr_sync                                  
);
reg [ADDRSIZE :0] rptr_ff;
always @ (posedge i_wclk or negedge i_wrst_n)begin
    if(i_wrst_n == 1'b0)begin 
        rptr_ff <= 0;
        o_rptr_sync <= 0;
    end
    else begin 
        rptr_ff <= i_rptr;
        o_rptr_sync <= rptr_ff;
    end
end
endmodule
