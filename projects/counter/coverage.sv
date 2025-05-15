class count_cov;
  
  count_tx tx;

  
  
  task run();
    tx=new();
    forever begin
    	count_common::mon2cov.get(tx);
      cg.sample();
    end
  endtask
  
  covergroup cg;
    ENABLE:coverpoint tx.i_en {
      bins UP = {1'b1};
      bins DOWN = {1'b0};
    }
    
    LOAD: coverpoint tx.i_load{
      bins Load_present = {1'b1};
      bins Load_absent = {1'b0};
    }
    
    //option.auto_bin_max=128;
  endgroup
  
    
  function new();
    cg=new();
  endfunction
endclass