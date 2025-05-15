class coverage;

// Instantiating Transaction class
tx t;

// Getting transaction from Monitor
task run();
	t = new();
	forever begin
		common::mon2cov.get(t);
		cg.sample();
	end
endtask

// Instantiating Coverpoints in Covergroup to all variables
covergroup cg;
// WR_RD : coverpoint t.wr_rd_en;   // Implictly bins are allocated based on the size.we wont write any bins here
	WR_RD:coverpoint t.wr_rd_en     // This Explicitly we will given to bins
	{
		bins WRITE = {1'b1};
		bins READ = {1'b0};
	}

// ADDR : coverpoint t.addr;        // This is implicitly we will given to bins
	ADDR_B:coverpoint t.addr
	{	    
        // Explicitly we given size to bins
		bins b1 = {[0:7]};
		bins b2 = {[8:15]};
		bins b3 = {[16:23]};
		bins b4 = {[24:31]};
		bins b5 = {[32:39]};
		bins b6 = {[40:47]};
		bins b7 = {[48:55]};
		bins b8 = {[56:63]};
        // we given number.automatically bins created according to size
        // option.auto_bin_max = 3 (or) 8;
	}
endgroup

// Allocating memory to the Cover group object
function new();
	 cg = new();
endfunction

endclass
