class bfm;

// Instantiating Transaction
tx t;

// Instantiating another Virtual interface, since we need virtual interface to drive transaction to DUT
virtual intrface vif;

// Assigning the handle of previous Physical/Virtual interface to this virtual interface
function new();
	vif = common::vif1;
endfunction

// Run task to get the Transaction from Mailbox 
task run();
    forever begin
		common::gen2bfm.get(t);   // getting the transaction
		drive_to_dut(t);          // driving the transaction
		t.print("BFM");           // printing BFM transaction
		common::bfm_count++;      // BFM transaction count
	end
endtask

// Drive task
task drive_to_dut(tx t1);   // driving the transaction from Interface to DUT
    @(vif.bfm_c);
	vif.bfm_c.addr_i <= t1.addr;    // driving ports from BFM to Interface
	if(t.wr_rd_en == 1) vif.bfm_c.w_data_i <= t1.w_data;

	vif.bfm_c.wr_rd_en_i <= t1.wr_rd_en;
	vif.bfm_c.valid_i <= 1;
	wait (vif.bfm_c.ready_o == 1);

    @(vif.bfm_c);
	if(t.wr_rd_en == 0) t.w_data = vif.bfm_c.rdata_o;

// top.reset_logic();
  vif.bfm_c.w_data_i <= 0;
  vif.bfm_c.valid_i <= 0;
  vif.bfm_c.addr_i <= 0;
  vif.bfm_c.wr_rd_en_i <= 0;

endtask

endclass
 
