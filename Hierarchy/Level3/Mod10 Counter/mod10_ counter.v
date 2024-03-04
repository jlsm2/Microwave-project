module mod10_counter (
	input wire CLK, Reset, 
	output reg [3:0] Q
);
	always @ (posedge CLK) begin
      if(Reset || Q == 4'b0000)
      		Q <= 4'b1001;
		else
			Q <= Q - 1;
	end
endmodule
  
