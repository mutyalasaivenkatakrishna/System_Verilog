interface count_intf(input logic i_clk,i_rst_n);
    parameter WIDTH      = 32;
    parameter SYNC_RESET = 0;

    logic i_en;
    logic i_up_down;
    logic i_load;     
    logic [WIDTH-1:0] i_load_data;
    logic [WIDTH-1:0] o_count ;
    logic o_ovf;
    logic o_udf;  
  
  clocking clkb @(posedge i_clk);
    
    output i_en;
    output i_up_down;
    output i_load;     
    output i_load_data;
    input o_count ;
    input o_ovf;
    input o_udf;  
    
  endclocking
  
    clocking clk_mon @(posedge i_clk);
    
    input i_en;
    input i_up_down;
    input i_load;     
    input i_load_data;
    input o_count ;
    input o_ovf;
    input o_udf;  
    
  endclocking
  
endinterface