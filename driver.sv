class driver;
  
  virtual fab_if.DRV fif;
  
   transaction trans_data;
  
  mailbox #(transaction) drv2gen;
  
  function new(mailbox #(transaction) drv2gen);
    this.drv2gen = drv2gen;
  endfunction
  
  task reset();
    fif.rst <= 1;
     fif.go  <= 0; 
        fif.n <= 0;
        repeat(5) @(posedge fif.clk) 
         fif.rst <= 0;
   
  endtask
  
  task run();
              trans_data = new();
      forever begin
           
        drv2gen.get(trans_data);
      
        fif.n <= trans_data.n;
   
        fif.go  <= trans_data.go;
        
      end
     
  endtask
endclass
