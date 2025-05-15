class UpDownCounterRefModel #(
  parameter WIDTH = 32,
  parameter SYNC_RESET = 0
);
  // Internal state
  protected bit [WIDTH-1:0] count;

  // Process a transaction and update state
  function void process(count_tx tr, bit rst_n);
    // Reset handling
    if (!rst_n) begin
      count = '0;
      tr.o_count = count;
      tr.o_ovf = 0;
      tr.o_udf = 0;
      return;
    end

    // Calculate overflow and underflow
    tr.o_ovf = tr.i_en && tr.i_up_down && (count == {WIDTH{1'b1}});
    tr.o_udf = tr.i_en && !tr.i_up_down && (count == 0);

    // Update counter
    if (tr.i_load) begin
      count = tr.i_load_data;
    end else if (tr.i_en) begin
      count = tr.i_up_down ? count + 1 : count - 1;
    end

    tr.o_count = count;
  endfunction

  // Get current counter value (for debugging)
  function bit [WIDTH-1:0] get_count();
    return count;
  endfunction
endclass