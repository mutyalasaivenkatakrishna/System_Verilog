module top;
	int arr1[];
	int arr2[];
	bit flag;
	initial begin
		arr1=new[5];//0:4
		arr2=new[5];
		for(int i=0;i<arr1.size();i++) begin
			arr1[i]=$urandom_range(10,50);
			arr2[i]=$urandom_range(20,60);
		end
		$display("arr1=%p",arr1);
		$display("arr2=%p",arr2);
		//Comparision -->if(arr1==arr2) 
		flag=1'b0;
		for(int i=0;i<arr1.size();i++) begin
			if(arr1[i]==arr2[i]) begin
				flag=1'b1;
			end
			else begin
				flag=1'b0;
				$display("Disntinct values are at %0d position arr1[%0d]=%0d,arr2[%0d]=%0d",i,i,arr1[i],i,arr2[i]);
				break;
			end
		end
		if(flag==1) begin
			$display("arrays are Similar");
		end
		else begin
			$display("arrays are Distinct");
		end
	end
endmodule
