// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "common.sv"
`include "transaction.sv"
`include "coverage.sv"
`include "monitor.sv"
`include "bfm.sv"
`include "generator.sv"
`include "agent.sv"
`include "ref_model.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "program.sv"
module top;
  reg i_clk,i_rst_n;
  count_pro pro();
  
  count_intf pif(i_clk,i_rst_n);
  up_down_counter dut(.i_clk(pif.i_clk),
                      .i_rst_n(pif.i_rst_n),
                      .i_en (pif.i_en),
                      .i_up_down(pif.i_up_down),
                      .i_load(pif.i_load),
                      .i_load_data(pif.i_load_data),
                      .o_count(pif.o_count),
                      .o_ovf(pif.o_ovf),
                      .o_udf(pif.o_udf)
                     );
  
  initial begin
    i_clk=0;
    forever #(1.33) i_clk = ~i_clk;
  end
  
  task reset_input();
  		pif.i_en <= 0;
    	pif.i_up_down <= 0;
        pif.i_load <= 0;
        pif.i_load_data <=0;
  endtask
  
  initial begin
  	count_common::vif=pif;
  end
  
  initial begin
    count_common::testcase="simple"; // change testcase
    i_rst_n=0;
    reset_input();
    
    repeat(2) @(posedge i_clk)
      i_rst_n=1;
  end
  
  initial begin
    #1000 $finish;
  end
endmodule