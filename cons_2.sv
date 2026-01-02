class sample;
	rand bit [7:0] arr [];
	
	function void print();
		$display("arr=%p",arr);
	endfunction
	
	constraint cons_a {
		arr.size()<15;
		foreach(arr[i]) {
			arr[i]<50;
			foreach(arr[j]) {
				if(i>j) arr[i]!=arr[j];
			}
		}
	}

endclass 

module top;
	sample s;

	initial begin
		s=new();
		repeat(5) begin
			assert(s.randomize());
			s.print();
		end	
	end
endmodule
// 3.Write a code example of how you would write a constraint for two different modes, A and B, with address ranges 0-1F and 2F-7F, respectively.

class sample;
	
	string mode;
	rand bit [15:0] address;
	
	function void print();
		$display("mode = %s",mode);
		$display("address = %h",address);
	endfunction
	
	constraint cons_a {
		mode == "A" -> address inside {[0:'h1F]};
		mode == "B" -> address inside {['h2f:'h7F]};
			}

endclass 

module top;
	sample s;

	initial begin
		s=new();
		repeat(2) begin
			s.mode="A";
			assert(s.randomize());
			s.print();
		end	
		repeat(2) begin
			s.mode="B";
			assert(s.randomize());
			s.print();
		end	
		repeat(2) begin
			s.mode="A";
			assert(s.randomize());
			s.print();
		end	
		repeat(2) begin
			s.mode="B";
			assert(s.randomize());
			s.print();
		end	
	end
endmodule
//4.Write constraint to generate 5,555,55,5555... etc. in random way?  

rand int a; a<10;

class sample;
	rand int t_c;
	 int numb;

	function void print();
		$display("%0d",numb);
	endfunction

	constraint cons_t {
		t_c inside {[1:6]};
	}

	function void post_randomize();
		numb=0;
		repeat(t_c) numb=numb*10 + 5;
	endfunction
endclass

//
class sample;

//	rand int nu;
	rand bit [3:0] arr[];
	function void print();
		$write("%p",arr);
	endfunction

	constraint cons_a {
		arr.size() < 10;
		foreach(arr[i]){
			arr[i] == 5;
		}
	}

endclass

module top;
	sample s;

	initial begin
		s=new();
		repeat(5) begin
			assert(s.randomize());
			s.print();
		end	
	end
endmodule

//5.how will you constrained address to get the address like below 0000, 0004, 0008, 000C, 0010... like that?  

class sample;
	rand bit[15:0] addr;
	int val;
	function void print();
		$write("%h ",addr);
	endfunction

	constraint cons_c {
      addr==val;
	}
  
  function void post_randomize();
    val=val+4;
  endfunction
  
endclass

module top;
	sample s;
	
	initial begin
		s=new();
		repeat(8) begin
			s.randomize();
			s.print();
		end
	end
endmodule

//Write a constraint to generate numbers between 10 to 10000 without repetition?

class sample;
	rand int numb;
	
	int arr[int];
	int count;

	function void print();
		$display("numb=%0d",numb);
	endfunction

	constraint cons {
		numb inside {[10:10000]};
       !(numb inside {arr});
	}

	function void post_randomize();
		arr[count]=numb;
		count++;
	endfunction

endclass

module top;
	sample s;
	
	initial begin
		s=new();
		repeat(10) begin
			assert(s.randomize());
			s.print();
		end
	end

endmodule

//7.Write a constraint to generate consecutive numbers

class sample;
	rand int numb;
	int las_num;
	bit a;
  
	function void print();
		$display("numb=%0d",numb);
	endfunction

	constraint cons{
      if(a==1) numb == las_num;
      else numb inside {[1:100]};
	}
	
	function void post_randomize();
      	a=1;
		las_num=numb+1;
	endfunction

endclass

module top;
	sample s;
	initial begin
		s=new();
		repeat(10) begin
			assert(s.randomize());
			s.print();
		end
	end
endmodule
//8. 5 bit variable -> should contains odd no of ones? 
//a.Do with systemtasks; 
//b.Do without systemtasks?
class sample;
  rand bit[4:0] numb;
  rand bit[4:0] number;
	function void print();
      $display("numb=%b",numb);
      $display("number=%b",number);
	endfunction
	
   //with systemtasks
	constraint cons{
      ($countones(numb))%2==1;
	}
	
   //Do without systemtasks
  constraint cons_a {
  		^number == 1;
  }
  
endclass

module top;
	sample s;
	initial begin
		s=new();
		repeat(10) begin
			assert(s.randomize());
			s.print();
		end
	end
endmodule

// 9.Write a contraints -> dynamic array  
// a.size should be randomize between 10 to 20  
// b.Each value should be odd 
// c.Array should be in ascending 
class sample;
  rand int arr[];
  
	function void print();
      $display("arr=%p",arr);
	endfunction
	
   
	constraint cons{
      arr.size inside {[10:20]};
	}
	

  constraint cons_a {
    foreach(arr[i]) {
      arr[i] inside {[1:100]};
      arr[i]%2 ==1;
    }
  }
      
      constraint cons_b {
        foreach(arr[i]) {
          foreach(arr[j]) {
            if(i>j) arr[i]> arr[j];
          }
        }
      }
  
endclass

module top;
	sample s;
	initial begin
		s=new();
		repeat(10) begin
			assert(s.randomize());
			s.print();
		end
	end
endmodule


//11.Write a constraint to generate variable with 32bits out of which 4 random bits should be 1 and remaining should be 0?

class sample;
	
	rand bit [31:0] number;
	
	function void print();
		$display("number= %b ",number);
	endfunction
	
	constraint cons_c {
		$countones(number) == 4;
	}


endclass

module top;
	sample s;
	initial begin
		s=new();
		repeat(10) begin
			assert(s.randomize());
			s.print();
		end
	end
endmodule

// 12.write a constraint where array size should be randomized and elements in the array should be divisible with 7 in odd locations and divisible with 5 in even array locations?

class sample;
	rand bit [7:0] arr [];
	
	function void print();
		$display("arr=%p",arr);
	endfunction
	
	constraint cons_a {
      arr.size() inside {[5:15]};
      foreach(arr[i]) {
        i%2 == 1 -> arr[i]%7 == 0 ;
        i%2 == 0 -> arr[i]%5 == 0;
      }
	}

endclass 

module top;
	sample s;

	initial begin
		s=new();
		repeat(5) begin
			assert(s.randomize());
			s.print();
		end	
	end
endmodule
//13.write a constraint where addr width is 32 and only 9th bit should be randomized?
class Que13;
  rand bit [31:0] addr;

  function void print();
    $display("addr = %b", addr);
  endfunction

  constraint cons_a {
    addr[7:0]   == 0;
    addr[31:9]  == 0;
  }
endclass

module top;
  Que13 s;

  initial begin
    s = new();
    repeat (5) begin
      assert(s.randomize());
      s.print();
    end
  end
endmodule
//14.write a constraint for same addr variable where it should take values only of 2 power?

class Que14;
  rand bit [31:0] addr;

  function void print();
    $display("addr = %0d", addr);
  endfunction

  constraint cons_a {
    $onehot(addr);
  }
endclass

module top;
  Que14 s;

  initial begin
    s = new();
    repeat (5) begin
      assert(s.randomize());      
      s.print();
    end
  end
endmodule

//15.write constraint for a variable of bit [7:0] to lie between 50 and 100?
class Que15;
  rand bit [7:0] vrb;

  function void print();
    $display("vrb = %0d", vrb);
  endfunction

  constraint cons_a {
    vrb inside {[50:100]};
  }
endclass

module top;
  Que15 s;

  initial begin
    s = new();
    repeat (5) begin
      assert(s.randomize());      
      s.print();
    end
  end
endmodule
//16.write a constraint for odd number and override the odd number with even number during randomization?
class parent;
  rand bit [7:0] vrb;

  constraint cons_a {
    vrb %2==1; // odd number
  }
endclass


class child extends parent;
  
   function void print();
    $display("vrb = %0d", vrb);
  endfunction
  
  constraint cons_a {
  	vrb %2==0;
  }
endclass

module top;
  child s;

  initial begin
    s = new();
    repeat (5) begin
      assert(s.randomize());      
      s.print();
    end
  end
endmodule
//17.Write a constraint to create a dynamic array of size less than 10 and each element of the array is less than 10
class Que17;
  rand int arr[];

  constraint c_size {
    arr.size() inside {[1:10]};
  }

  constraint c_values {
    
    foreach (arr[i])
      arr[i] inside {[0:10]};
  }

  function void print();
    $display("size = %0d, arr = %p", arr.size(), arr);
  endfunction
endclass

module top;
  Que17 q;

  initial begin
    q = new();
    repeat (5) begin
      assert(q.randomize());
      q.print();
    end
  end
endmodule
// 19.write a constraint to generate an array of size 10 with output as 0,0,1,1,1,0,0,1,1,1,

class Que19;
  rand bit arr[];
  
  constraint c_size {
    arr.size() == 10;
  }

 constraint c_pattern {
  foreach (arr[i]) {
    if (i inside {[0:1], [5:6]})
      arr[i] == 0;
    else
      arr[i] == 1;
  }
}


  function void print();
    $display("arr = %p", arr);
  endfunction
endclass

module top;
  Que19 q;
  initial begin
    q = new();
    assert(q.randomize());
    q.print();
  end
endmodule

//20.Question: Write a SystemVerilog class with a random variable data of type bit [7:0] and apply a constraint to ensure that the value is always less than 100.
class Que20;
  rand bit [7:0] data;

  constraint c_data {
    data < 100;
  }

  function void print();
    $display("data = %0d", data);
  endfunction
endclass

module top;
  Que20 q;

  initial begin
    q = new();
    repeat (5) begin
      assert(q.randomize());
      q.print();
    end
  end
endmodule

// 22.Question: Develop a SystemVerilog class with a random variable temperature of type real representing temperature in Celsius. Apply a soft constraint to encourage the temperature to be between 0 and 100 degrees but allow deviations.
class Que22;
  rand real temperature;

  constraint c_temp {
    soft temperature inside {[1.0 : 100.0]};
  }

  function void print();
    $display("Temperature = %0.2f °C", temperature);
  endfunction
endclass

module top;
  Que22 t;

  initial begin
    t = new();

    // Normal randomization → prefers 0–100
    repeat (5) begin
      assert(t.randomize());
      t.print();
    end

    // Override soft constraint → deviation allowed
    assert(t.randomize() with { temperature > 120.0; });
    t.print();
  end
endmodule

// 23.Question: Implement a SystemVerilog class with two random variables a and b of type bit. Apply an implication constraint such that if a is 1, then b must be 0.

class Que23;
  rand bit a;
  rand bit b;

  constraint c_implication {
    a == 1 -> b == 0;
  }

  function void print();
    $display("a = %0d, b = %0d", a, b);
  endfunction
endclass

module top;
  Que23 q;

  initial begin
    q = new();
    repeat (6) begin
      assert(q.randomize());
      q.print();
    end
  end
endmodule

// 24.Question: Construct a SystemVerilog class with a random variable choice of type int. Apply weighted constraints to bias the randomization towards the values 0 and 1.
class Que24;
  rand int choice;

  constraint c_weighted {
    choice dist {
      0 := 40,
      1 := 40,
      [2:10] := 20
    };
  }

  function void print();
    $display("choice = %0d", choice);
  endfunction
endclass

module top;
  Que24 q;

  initial begin
    q = new();
    repeat (20) begin
      assert(q.randomize());
      q.print();
    end
  end
endmodule

