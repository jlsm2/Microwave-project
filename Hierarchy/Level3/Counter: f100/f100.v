module ContadorFreq100 (
    input wire clk_100Hz,
    output reg Hz1        
);

  reg [25:0] count = 26'b00000000000000000000000000; 

always @(posedge clk_100Hz) begin
  if (count == 26'b10111110101111000010000000) begin 
        count <= 26'b0; 
        Hz1 <= 1;
    end else begin
        Hz1 <= 0;
        count <= count + 1; 
    end
end

endmodule
