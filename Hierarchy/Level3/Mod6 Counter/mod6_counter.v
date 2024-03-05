module mod6_counter (
    input wire CLK, Reset, 
      output reg [2:0] Q
);
    always @ (posedge CLK) begin
      if(Reset || Q == 3'b000)
              Q <= 3'b101;
        else
            Q <= Q - 1;
    end
endmodule
