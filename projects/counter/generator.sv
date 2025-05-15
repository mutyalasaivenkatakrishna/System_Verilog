class count_gen;
  
  count_tx tx;
  task run();
    case(count_common::testcase)
      "simple": begin
        repeat(5) begin
    			tx=new();
         		tx.randomize();
    			count_common::gen2bfm.put(tx);
      			tx.print("gen");
    		end
      end
    endcase  
  endtask
  
endclass