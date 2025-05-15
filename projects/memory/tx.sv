class tx;

// Randomizing inputs that are required for Generating Transaction
rand bit[`WIDTH-1:0]w_data;
rand bit[`ADDR_WIDTH-1:0]addr;
rand bit wr_rd_en;

// Defining Print method for better visuality of Output
function void print(string name = "Transaction");
    $display("This is %s Transaction",name);
	if(wr_rd_en == 1) begin
	   $display("WRITE_DATA is \t time=%0t \t addr=%0h \t w_data=%0h",$time,addr,w_data);
	end 
	else begin
	   $display("READ_DATA is \t time=%0t \t addr=%0h \t w_data=%0h",$time,addr,w_data);
		
	end
	
	//$display("time=%0t,addr=%0h",$time,addr);
	//$display("wr_rd_en=%0d",wr_rd_en);

endfunction

endclass
