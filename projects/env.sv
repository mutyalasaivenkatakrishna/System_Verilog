class env;

// Instantiate agent and Scoreboard inside Environment
agent a;
scoreboard s;

// Allocate memory for the Objects of Agent & Scoreboard 
function new();
	a = new();
 	s = new();
endfunction

// Run task for Agent & Scoreboard
task run();
   fork
	  a.run();
	  s.run();
   join	
endtask

endclass
