// It is similar to Memory module, but the differenec is all the ports are considered as Inputs
module mem_assert(clk_i,rst_i,valid_i,wr_rd_en_i,addr_i,w_data_i,rdata_o,ready_o);

// Parameters
parameter DEPTH = 64;
parameter WIDTH = 4;
parameter ADDR_WIDTH = $clog2(DEPTH);

// All the ports are defined as Inputs
input [WIDTH-1:0]w_data_i;
input [ADDR_WIDTH-1:0]addr_i;
input clk_i,valid_i,rst_i,wr_rd_en_i;
input [WIDTH-1:0]rdata_o;
input ready_o;

// Handshake
property handshaking;
	@(posedge clk_i) valid_i == 1 |-> ##1 ready_o == 1;  //   Antacedent   |->   Consequent  |=>
endproperty
HANDSHAKING:assert property(handshaking);

// Enable input
property wr_rd;
	@(posedge clk_i) valid_i == 1 && ready_o == 1 |-> wr_rd_en_i == 1 || wr_rd_en_i == 0 ;
endproperty
WRITE_READ_ASSERT:assert property(wr_rd);

// Write data
property data;
	@(posedge clk_i) wr_rd_en_i==1 |-> ##0 !($isunknown(addr_i)) && !($isunknown(w_data_i));
endproperty
WR_RD_ADDR_DATA:assert property(data);

// Read data
property rdata;
@(posedge clk_i) wr_rd_en_i==0 |-> ##1 !($isunknown(addr_i)) && !($isunknown(rdata_o));
endproperty
WR_RD_ADDR_RDATA:assert property(rdata);

endmodule


