class scoreboard;
  
  localparam int max_output_value = 2178309;
  
   transaction trans_sco;
  
  mailbox #(transaction) sco2mon;
  
 event next;
    int actual,expected,n_f;
  //int index = 0;
  int pass_count =0;
  int fail_count =0;
  
  function new(mailbox #(transaction) sco2mon);
    this.sco2mon = sco2mon;

  endfunction
  
 
 function void fibonacci(transaction trans_sco);
   
   n_f= trans_sco.n; 
   
   if (n_f <= 1) 
      expected = 0;
   if(n_f == 2)
      expected = 1;
   if  (n_f > 2)
     expected = fibonacci_recursive(n_f);
   else 
     expected = 0;
 //  $display("[n_f]: is %0d",expected);
endfunction

     function int fibonacci_recursive(input int n);
       if (n <= 1) 
        return 0;
       else if (n == 2)
        return 1;
    return fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2);
endfunction
 
  
  task verify_output(transaction trans_sco);
    
        //trans_sco.index=20;
    	actual = trans_sco.result ;
    
   // $display("Actual result with %0d", actual);
    
     fibonacci(trans_sco);
  //  $display("Fibonacci(%0d) with %0d", expected, n_f);    
    
   
    
    if (expected !== actual) begin
      		if (expected >= max_output_value) begin
        trans_sco.overflow = 1;
      		end
   			 else begin
              trans_sco.overflow = 0;
    		end
      $display("Test failed for n= %0d: expected : %0d : actual : %0d :overflow : %0d ", n_f,expected, actual, trans_sco.overflow);
    fail_count++;
    end
    else begin
       		if (expected >= max_output_value) begin
        trans_sco.overflow = 1;
     		 end
    		else begin
              trans_sco.overflow = 0;
    		end
      $display("Test Passed for n= %0d: expected : %0d : actual : %0d :overflow : %0d ",trans_sco.n,expected, actual, trans_sco.overflow);
   pass_count++;
    end 
    
    //int verify = fibonacci(trans_sco);
    //$display("Fibonacci(%0d)", n_f);    
  endtask
  
  ////Task when done = 0 ///
  
  task verify_cond(transaction trans_sco);
    
    	actual = trans_sco.result ;
        
     fibonacci(trans_sco);
     
    if (( trans_sco.done) == 1'b0) begin
      expected = 0;
      trans_sco.overflow = 0;
      $display("Test passed for n= %0d: expected : %0d : actual : %0d :overflow : %0d ", trans_sco.n,expected, actual, trans_sco.overflow);
     pass_count++;
    end
    else begin
       	    verify_output(trans_sco);
    end 
      
  endtask
  
  
  task run();
         trans_sco = new();
    forever begin
      #20;
      sco2mon.get(trans_sco);
      trans_sco.display("[SCO]");
      verify_cond(trans_sco);
      ->next;
      
    end
        
  endtask
    
/*  initial begin
    for (int i =0 ; i <=20; i++) begin
      index = i;
  end
  */
endclass : scoreboard
