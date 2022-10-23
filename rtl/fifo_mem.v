/*=============================================================================
#
# Author: mengguodong Email: 823300630@qq.com
#
# Personal Website: guodongblog.com
#
# Last modified: 2022-10-23 11:12
#
# Filename: fifo_mem.v
#
# Description: 
#
=============================================================================*/
module FIFO_MEM #(  parameter DATASIZE = 8,
                    parameter ADDRSIZE = 4)(
    input   wire    [DATASIZE -1: 0]          i_wdata                                      ,
    input   wire    [ADDRSIZE -1: 0]          i_waddr                                      ,
    input   wire    [ADDRSIZE -1: 0]          i_raddr                                      ,
    input   wire                              i_w_en                                       ,
    input   wire                              i_wfull_flag                                 ,
    input   wire                              i_wclk                                       ,
    output  wire    [DATASIZE -1: 0]          o_rdata
);
//*************************************************\
//define parameter and intennal singles
//*************************************************/

//*************************************************\
//main code
//*************************************************/
`ifdef VENDORRAM
vendor_ram men (
    .dout                                                  (o_rdata                                               ),
    .din                                                   (i_wdata                                               ),
    .waddr                                                 (i_waddr                                               ),
    .wclken                                                (i_w_en                                                ),
    .clk                                                   (i_wclk                                                ));
`else
localparam DATADEPTH = 1<<ADDRSIZE;
reg [DATASIZE - 1: 0] mem [DATADEPTH-1:0];
assign o_rdata = mem[i_raddr];
always @ (posedge i_wclk)begin 
    if((i_w_en == 1'b1) && (i_wfull_flag == 1'b0)) 
        mem[i_waddr] <= i_wdata;
end
`endif
endmodule
