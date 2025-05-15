class monitor;

// Instantiating the Transaction class
tx t;

// Instantiating the Virtual interface
virtual intrface vif;

// Assigning handle of Physical interface to Virtual interface
function new();
	vif = top.pif;
endfunction

// Run task to send the transaction from Interface to Monitor
task run();
	t = new();
	forever begin
	  @(vif.mon_c);
	  if(vif.mon_c.valid_i == 1 && vif.mon_c.ready_o == 1)begin  // Hand shaking
		t.addr = vif.mon_c.addr_i;
		t.wr_rd_en = vif.mon_c.wr_rd_en_i;
		if(vif.mon_c.wr_rd_en_i == 1) 
			t.w_data = vif.mon_c.w_data_i;
		else  
			t.w_data = vif.mon_c.rdata_o;

	  t.print("Monitor"); // to see the transaction in Monitor

	  common::mon2cov.put(t);   // putting transaction in mailbox inorder to send to Coverage.
	  common::mon2sbd.put(t);   // putting transaction in mailbox inorder to send to Scoreboard.

	 end
	end
endtask

endclass
