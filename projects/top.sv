module top;
reg clk;
reg reset;

// Clock Generation
initial begin
 clk=0;
 forever #5 clk=~clk;
end

env e;  // Environment instantiation

// Physical Interface instantiation
intrface pif(clk,reset);

// Assigning Physical interface handle to Virtual Interface.
initial begin
	common :: vif1 = pif;
end

// DUT instantiation   // driving ports from Interface to DUT. 
memory dut(.clk_i(pif.clk_i),.rst_i(pif.rst_i),.valid_i(pif.valid_i),.wr_rd_en_i(pif.wr_rd_en_i),.addr_i(pif.addr_i),
.w_data_i(pif.w_data_i),.rdata_o(pif.rdata_o),.ready_o(pif.ready_o));

// Assertion files Instantiation
mem_assert  dut_assert(.clk_i(pif.clk_i),.rst_i(pif.rst_i),.valid_i(pif.valid_i),.wr_rd_en_i(pif.wr_rd_en_i),.addr_i(pif.addr_i),
.w_data_i(pif.w_data_i),.rdata_o(pif.rdata_o),.ready_o(pif.ready_o));

// Reset task
task reset_logic(); 
	pif.w_data_i = 0;
	pif.valid_i = 0;
    pif.addr_i = 0;
    pif.wr_rd_en_i = 0;
endtask

// Allocate memory for environment object and Run
initial begin
    //$value$plusargs("testcase=%s",common::testcase);
    reset = 1;
	reset_logic();
	repeat(2)@(posedge clk)
    reset = 0;
	e = new();    // Assign memory to environment object
	e.run();      // Running environment
end

// Reporting for better understanding
initial begin
	#50;
//	wait(common::tx_count == common::bfm_count);
	wait(2*common::count == common::bfm_count);
	#100;
	if(common::num_matches==0 && common::num_miss_matches!=0)begin
	     $display("###############################################");
		 $display("%0t \t TestFailed \t num_matches=%0d \t num_miss_matches=%0d",$time,common::num_matches,common::num_miss_matches);
	     $display("###############################################");
	end
	else begin
	     $display("###############################################");
		 $display("%0t \t TestPass \t num_matches=%0d \t num_miss_matches=%0d",$time,common::num_matches,common::num_miss_matches);
	     $display("###############################################");
	end

	#100;
    //#2000;
	$finish;
end
endmodule
