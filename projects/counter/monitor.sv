class count_mon;
  count_tx tx;
  virtual count_intf vif;
  
  function new();
    vif=top.pif;
  endfunction
  
  task run();
    tx=new();
    forever begin
      @(vif.clk_mon);
      tx.i_en <= vif.i_en;
      tx.i_up_down <= vif.i_up_down;
      tx.i_load <= vif.i_load;
      tx.i_load_data <= vif.i_load_data;
      tx.o_count <= vif.o_count;
      tx.o_ovf <= vif.o_ovf;
      tx.o_udf <= vif.o_udf;
     // tx.print("monitor");
      count_common::mon2cov.put(tx);
      count_common::mon2sbd.put(tx);
    end
  endtask
endclass