module sr_latch (
  input wire S, R,
  output reg Q, Qbar
);
  
  always@(S or R) begin
    if(R) begin
      Q <= 0;
      Qbar <= 1;
    end
    else if(S) begin
      Q <= 1;
      Qbar <= 0;
    end
  end
endmodule
