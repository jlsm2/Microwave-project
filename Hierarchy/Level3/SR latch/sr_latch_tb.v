module sr_latch_tb;
  
  reg S, R;
  wire Q, Qbar;
  
  sr_latch uut(
    .S(S),
    .R(R),
    .Q(Q),
    .Qbar(Qbar)
  );
  
  always #5 S = ~S;
  
  initial begin
    $dumpfile("latch.vcd"); 
    $dumpvars;
  end
  
  initial begin
    S = 0;
    R = 0;
    
    #20 S = 1;
    #10 S = 0;
    #10;
    
    R = 1;
    #20 R = 0;
    #10;
    
    S = 1;
    R = 1;
    #20;
    
    S = 1;
    #100;
    
    R = 1;
    #100;
    
    $finish;
  end
endmodule
