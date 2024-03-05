module mux2_to_1 (
  input wire a, b,
  input wire sel,
  output reg Q
);
  always@(*) begin
    if(sel == 1'b0)
      Q = a;
    else
      Q = b;
  end
endmodule
