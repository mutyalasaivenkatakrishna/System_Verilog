

class count_sb;

  // Instantiating transaction
  count_tx t;
  count_tx ref_t;

  // Reference model
  UpDownCounterRefModel #(32, 0) ref_model;

  // Constructor
  function new();
    ref_model = new();
  endfunction

  // Comparing DUT outputs with reference model
  task run(bit rst_n);
    
    forever begin
      t = new();
      count_common::mon2sbd.get(t); // Getting transaction from monitor
      ref_t = new();
      ref_t.copy(t); // Copy transaction for reference model

      // Process through reference model
      ref_model.process(ref_t,top.i_rst_n);

      // Compare DUT outputs with reference model
      if (t.o_count == ref_t.o_count &&
          t.o_ovf == ref_t.o_ovf &&
          t.o_udf == ref_t.o_udf) begin
        count_common::num_matches++;
        $display("%0t \t num_matches = %0d", $time, count_common::num_matches);
      end else begin
        count_common::num_miss_matches++;
        $display("%0t \t num_miss_matches = %0d, DUT: count=%h, ovf=%b, udf=%b | Ref: count=%h, ovf=%b, udf=%b",
                 $time, count_common::num_miss_matches,
                 t.o_count, t.o_ovf, t.o_udf,
                 ref_t.o_count, ref_t.o_ovf, ref_t.o_udf);
      end
    end
  endtask

endclass