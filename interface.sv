interface fab_if #(parameter int INPUT_WIDTH = 6, parameter int OUTPUT_WIDTH = 32);
  
  //declaring the signals
  logic       go;
  logic     [INPUT_WIDTH-1:0]   n;
  logic       overflow;
  logic [OUTPUT_WIDTH-1:0] result;
  logic   done;
  logic clk,rst;
  
  modport DRV (input result,overflow,done, output clk,rst,go,n);
  
  modport MON (input result,overflow,done,clk,rst,go,n);
  
endinterface