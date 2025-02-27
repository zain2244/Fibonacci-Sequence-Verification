class transaction #(parameter int INPUT_WIDTH = 6, parameter int OUTPUT_WIDTH = 32);
  
  rand  bit go ;
  rand bit [INPUT_WIDTH-1:0]  n;
  bit  overflow;
  bit done;
  bit [OUTPUT_WIDTH-1:0]  result;

  
 constraint n_datd{ n>0; n< 20;}
  
  
  function void display(input string tag);
    $display("%0s\t: go : %0b\t n : %0d\t : overflow: %0b\t result: %0d\t done: %0b\t , @ %0t",tag,go,n,overflow,result,done,$time);
  endfunction
  
  function transaction copy();
    copy = new();
    copy.go = this.go;
    copy.n  = this.n;
    copy.overflow = this.overflow;
    copy.result = this.result;
	copy.done = this.done;
  endfunction 
endclass: transaction;
