class agent;

// Instantaite all the agents and allocate memory using new method
gen g = new();
bfm b = new();
monitor m = new();
coverage cov = new();

// Run task for running Agents in the Environment
task run();
    fork
		g.run();
		b.run();
		m.run();
		cov.run();
	join
endtask

endclass
