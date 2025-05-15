class scoreboard;

// Instantiating transaction
tx t;

// Reference Model [ Reference Memory ]
bit[`WIDTH-1:0]score_mem[int];

// Comparing the data in Reference Model with data in Scoreboard
task run();
   forever begin
   		t = new();
   	 common::mon2sbd.get(t);   // Getting transaction to Scoreboard from Monitor
   	 if(t.wr_rd_en == 1)begin
   	 	score_mem[t.addr] = t.w_data;  // storing write data in Scoreboard memory.
   	 end
   	 else begin
   	 	if(score_mem[t.addr] == t.w_data)begin   // Checker - Comapares data in Scoreboard and DUT ( Scoreboard data == DUT data ) 
   	 		common::num_matches++;
   	 		$display("%0t \t num_matches = %0d",$time,common::num_matches);
   	 	end
   	 	else begin
   	 		common::num_miss_matches++;	
   	 		$display("%0t \t num_matches = %0d",$time,common::num_miss_matches);
   	 	end
   	 end
 end	
endtask
endclass
