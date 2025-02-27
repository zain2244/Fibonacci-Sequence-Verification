class monitor;
  
    virtual fab_if.MON fif;
  
   transaction trans_m;
  
  mailbox #(transaction) mon2sco;
  
  //int count = 0;
  
  task test2();
    if ( ( trans_m.done) == 1'b1) begin
                 trans_m.result =  fif.result;
       end 
 		   else begin
     trans_m.result =  0;
    end
    endtask
  
  function new(mailbox #(transaction) mon2sco);
    this.mon2sco = mon2sco;
	this.fif = fif;
     trans_m = new();
  endfunction
  
      task run();

        forever begin
         // repeat(2)
                  @(posedge fif.clk)
            trans_m.go = fif.go; 
           trans_m.n =  fif.n ;
            trans_m.done = fif.done ;
            trans_m.overflow = fif.overflow;
           /// trans_m.display("[MON]");
          test2();
      //    $display("value of result is %0d",trans_m.result);
          trans_m.display("[MON]");
                  mon2sco.put(trans_m);
          /*
           #20;
            trans_m.result = 0;
          end
          else begin
             @(posedge fif.clk)
            trans_m.result = fif.result;
          end
          */

      //    $display("The result is %0d",trans_m.result);

          end

      endtask
endclass : monitor