class count_env;
  count_agent agent;
  count_sb sbd;
  
  function new();
    agent=new();
    sbd=new();
  endfunction
  
  task run();
    fork
    	agent.run();
      sbd.run(top.i_rst_n);
    join
  endtask
  
endclass