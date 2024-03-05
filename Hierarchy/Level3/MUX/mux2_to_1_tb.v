module mux2_to_1_tb;
  reg a, b, sel;
  wire Q;
  
  mux2_to_1 uut (
    .a(a),
    .b(b),
    .sel(sel),
    .Q(Q)
  );
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  initial begin
    $monitor("Time=%0t, a=%b, b=%b, sel=%b, Q=%b", $time, a, b, sel, Q);
    
    a = 0; b = 0; sel = 0;
    #10;
    
    a = 0; b = 0; sel = 1;
    #10;
    
    a = 0; b = 1; sel = 0;
    #10;
    
    a = 0; b = 1; sel = 1;
    #10;
    
    a = 1; b = 0; sel = 0;
    #10;
    
    a = 1; b = 0; sel = 1;
    #10;
    
    a = 1; b = 1; sel = 0;
    #10;
    
    a = 1; b = 1; sel = 1;
    #10;
    
    $finish;
  end
endmodule
