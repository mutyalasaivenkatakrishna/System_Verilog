module memory(clk_i,rst_i,valid_i,wr_rd_en_i,addr_i,w_data_i,rdata_o,ready_o);
parameter DEPTH=64;
parameter WIDTH=4;
parameter ADDR_WIDTH=$clog2(DEPTH);
input [WIDTH-1:0]w_data_i;
input [ADDR_WIDTH-1:0]addr_i;
input clk_i,valid_i,rst_i,wr_rd_en_i;
reg [WIDTH-1:0]mem[DEPTH-1:0];
output reg [WIDTH-1:0]rdata_o;
output reg ready_o;
integer i;
reg [8*50-1:0]testcase;
always @(posedge clk_i)begin
	if(rst_i==1)begin
		rdata_o=0;
		ready_o=0;
		for(i=0;i<DEPTH;i=i+1)begin
			mem[i]=0;
		end
	end	
	else begin
		if(valid_i==1)begin
			ready_o=1;
			if(wr_rd_en_i==1)begin
				mem[addr_i]=w_data_i;
			end
			else begin
				rdata_o=mem[addr_i];
			end
		end	
	    else begin	
			ready_o=0;
		end	
	end

end
endmodule
			




