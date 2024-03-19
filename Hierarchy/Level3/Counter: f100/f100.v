module ContadorFreq100 (
    input wire clk_100Hz,
    output reg Hz1        
);

reg [6:0] count = 7'b0000000; 

always @(posedge clk_100Hz) begin
    if (count == 7'b1100100) begin 
        count <= 7'b0; 
        Hz1 <= ~Hz1; //inverte o sinal a cada ciclo de clock para obter 1 Hz
    end else begin
        count <= count + 1; 
    end
end

endmodule
