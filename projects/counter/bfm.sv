class count_bfm;
  
  count_tx tx;
 virtual count_intf vif;
  
  function new();
    vif=top.pif;
  endfunction
  
  task run();
    forever begin
      tx=new();
      count_common::gen2bfm.get(tx);
      //tx.print("bfm");
      drive_tx(tx);
    end
  endtask
  
  task drive_tx(count_tx tx);
    @(vif.clkb)
    vif.clkb.i_en <= tx.i_en;
    vif.clkb.i_up_down <= tx.i_up_down;
    vif.clkb.i_load <= tx.i_load;
    vif.clkb.i_load_data <= tx.i_load_data;
    tx.o_count <= vif.clkb.o_count;
    tx.o_ovf <= vif.clkb.o_ovf;
    tx.o_udf <= vif.clkb.o_udf;
  endtask
  
endclass