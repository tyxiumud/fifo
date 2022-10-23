module SYNC_RST(
    input   wire                            i_clk                                        ,
    input   wire                            i_rst_n                                      ,
    output  wire                            o_rst_n                                      
        );
reg ff1;
reg ff2;
always @ (posedge i_clk or negedge i_rst_n)begin
    if(i_rst_n == 1'b0)begin
        ff1 <= 1'b0;
        ff2 <= 1'b0;
    end
    else begin
        ff1 <= 1'b1;
        ff2 <= ff1;
    end
end
assign o_rst_n = ff2;
endmodule
