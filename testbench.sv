
//including interfcae and testcase files
`include "interface.sv"

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
//`include "directed_test.sv"
//----------------------------------------------------------------
`include "environment.sv"

module tb();
  
 // transaction trans;
  
  fab_if fif();
   
  enviroment env;
 
  fib dut (
    fif.clk,
    fif.rst,
    fif.go,
    fif.n, 
    fif.result,
    fif.overflow,
    fif.done
   );
   
  initial begin
    fif.clk = 0;
    fif.rst = 1;
  end
  
  always #10 fif.clk = ~fif.clk;
  
  initial begin
    env = new(fif);
    env.gen.count = 80;
    env.run();

  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
   
  end
  
endmodule

