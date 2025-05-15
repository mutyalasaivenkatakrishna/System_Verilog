class count_tx;
  
parameter WIDTH      = 32;
//parameter SYNC_RESET = 0;

  
  rand bit i_en ;       
  rand bit i_up_down;   
  rand bit i_load ;
  rand bit [WIDTH-1:0] i_load_data;
  
  bit  [WIDTH-1:0] o_count;    // Counter output
  bit  o_ovf;       // Overflow flag
  bit o_udf;

  function void print(string name="count_tx");
    $display("tx=%s", name);
    $display("i_en=%b",i_en);
    $display("i_up_down=%b",i_up_down);
    $display("i_load=%b",i_load);
    $display("i_load_data=%0d",i_load_data);
    $display("o_count=%0d",o_count);
    $display("o_ovf=%b",o_ovf);
    $display("o_udf=%b",o_udf);
  endfunction
  
  
 function void copy(count_tx src);
  this.i_en = src.i_en;
  this.i_up_down = src.i_up_down;
  this.i_load = src.i_load;
  this.i_load_data = src.i_load_data;
/*  this.o_count = src.o_count;
  this.o_ovf = src.o_ovf;
  this.o_udf = src.o_udf; */
endfunction

endclass