class count_agent;
  
  count_gen gen; 
  count_bfm bfm;
  count_mon mon;
  count_cov cov;
  
  function new();
    gen=new();
    bfm=new();
    mon=new(); 
    cov=new();
  endfunction
  
  task run();
    fork
      bfm.run();
      gen.run();
      mon.run();
      cov.run();
    join
  endtask
  
endclass