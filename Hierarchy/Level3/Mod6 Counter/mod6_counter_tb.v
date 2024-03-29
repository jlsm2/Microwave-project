module mod6_counter_tb();
    reg CLK, Reset;
      wire [2:0] Q;
      mod6_counter c1(CLK,Reset,Q);
    initial begin
          CLK = 0;
        forever #5 CLK = ~CLK;
    end
    initial begin
          Reset = 0;
          #5 Reset = 1;
          #10 Reset = 0;
          #200 $finish;
    end
    initial
          $monitor("%d    %d", CLK, Q);
    initial begin
          $dumpfile("dump.vcd"); 
          $dumpvars;
    end
endmodule
