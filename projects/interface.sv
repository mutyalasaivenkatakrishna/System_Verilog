// Parameters
`define DEPTH 64
`define WIDTH 4
`define ADDR_WIDTH $clog2(`DEPTH)

// Define Interface  [ Common ports of Interface (clock, reset) ] 
interface intrface(input logic clk_i,input logic rst_i);  // interface inputs

// Ports in Interface
logic [`WIDTH-1:0]rdata_o;
logic ready_o;
logic [`WIDTH-1:0]w_data_i;
logic [`ADDR_WIDTH-1:0]addr_i;
logic valid_i;
logic wr_rd_en_i;

// BFM Clocking block
clocking bfm_c @(posedge clk_i);
default input #1 output #0;
 input #0 rdata_o; 
 input #0 ready_o;
 output #1 w_data_i;
 output #1 addr_i;
 output #1 valid_i;
 output #1 wr_rd_en_i;
endclocking 

// Monitor Clocking block
clocking mon_c @(posedge clk_i);
default input #1 ;
    input rdata_o;
    input ready_o;
	input wr_rd_en_i;
	input addr_i;
	input w_data_i;
	input valid_i;
endclocking 

endinterface
