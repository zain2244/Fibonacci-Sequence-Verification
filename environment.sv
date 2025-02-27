//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class enviroment;
  
  virtual fab_if fif;
   mailbox #(transaction) gen2drv;
   mailbox #(transaction) mon2sco;
  
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  event nextgs;
  
  function new( virtual fab_if fif);
    

    gen2drv = new();
    
    gen = new(gen2drv);
    drv = new(gen2drv);
    
    mon2sco = new();
    
    mon = new(mon2sco);
    sco = new(mon2sco);
    
  ///  gen.count = 20;
    
	this.fif = fif;
    drv.fif = fif;
     mon.fif = fif;
    
    gen.next = nextgs;  //merging both events//
    sco.next = nextgs;
  endfunction
  
  //declare pre_test, test, post_test//
  
  task pre_test();
    drv.reset();
  endtask
    
	task test();
      fork
      gen.run();
      drv.run();
      mon.run();
     //   mon.test2();
      sco.run();
      join_any
    endtask
  
  task post_task();
    wait(gen.complete.triggered);
    $display("Total Passed: %0d, Total Failed: %0d", sco.pass_count, sco.fail_count);
    $finish();
  endtask
  
  task run();
    pre_test();
    test();
    post_task();
  endtask
  
endclass : enviroment