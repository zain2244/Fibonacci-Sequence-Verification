class generator;
  
///  transaction trans;
  transaction trans;
 // transaction directed_sequence[9];
  
  mailbox #(transaction) gen2drv;
  
  event next;
  event complete;
  int count;
  
  function new(mailbox #(transaction) gen2drv);
    this.gen2drv = gen2drv;
   trans = new();
/*
    directed_sequence[0] = new();
    directed_sequence[0].go = 1;
    directed_sequence[0].n = 0;
    
    directed_sequence[1] = new();
    directed_sequence[1].go = 0;
    directed_sequence[1].n = 1;
    
    directed_sequence[2] = new();
    directed_sequence[2].go = 1;
    directed_sequence[2].n = 2;
    
    directed_sequence[3] = new();
    directed_sequence[3].go = 1;
    directed_sequence[3].n = 3;
    
    directed_sequence[4] = new();
    directed_sequence[4].go = 0;
    directed_sequence[4].n = 4;
    
    directed_sequence[5] = new();
    directed_sequence[5].go = 1;
    directed_sequence[5].n = 5;
    
    directed_sequence[6] = new();
    directed_sequence[6].go = 1;
    directed_sequence[6].n = 6;
    
    directed_sequence[7] = new();
    directed_sequence[7].go = 0;
    directed_sequence[7].n = 7;
    
    directed_sequence[8] = new();
    directed_sequence[8].go = 1;
    directed_sequence[8].n = 8;
   */   
  endfunction
  

  task run();
    
    /*
    for (int i = 0; i <=8 ; i++) begin
      
      trans = directed_sequence[i];
       trans.display("[GEN]");
      gen2drv.put(trans.copy);
      @(next);
    end
   */
    repeat (count) begin
    assert (trans.randomize())
      else
        $display("Randomization failed"); 
    trans.display("[GEN]");
      gen2drv.put(trans.copy);
      #20;
      
      @(next);
    //  #20;
    end
     
    ->complete;
  endtask
endclass: generator