class gen;

// Instantiating the Transaction twice
tx t1;
tx t2;
//bit [`ADDR_WIDTH-1:0]addr_t;

// Defining a Queue to store one Transaction
tx queue[$];

// Run task to allocate memory for tx class object and generate the Transaction and put it in the Mailbox.
task run();
	case(common::testcase)
	//	"single_wr_rd":begin    
	//		t1=new();
	//		// Write
	//		assert(t1.randomize() with {wr_rd_en == 1;});
	//		addr_t = t1.addr;
	//		common::gen2bfm.put(t1);
	//		// Read
	//		t1=new();
	//	    assert(t1.randomize() with {wr_rd_en == 0;addr == addr_t;});
	//		common::gen2bfm.put(t1);
	//	end
        "multiple_wr_rd":begin
		    common::tx_count = 2*common::count;
			repeat(common::count)begin
				t1 = new();
				// Write
				assert(t1.randomize() with {wr_rd_en == 1;});
				queue.push_back(t1);      // storing transaction in queue
				common::gen2bfm.put(t1);  // storing transaction in mailbox
			end

			repeat(common::count)begin
				// Read
				t1 = new();
			   	t2 = queue.pop_front();
		    	assert(t1.randomize() with {wr_rd_en == 0; t1.addr == t2.addr;});
// we need to mention the address in constraint so that read operation occurs in the same address where the write operation occurs
				common::gen2bfm.put(t1);
			end
		end		
	endcase
endtask

endclass

