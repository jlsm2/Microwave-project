module ContadorFreq100 (
    input wire clk_100Hz, // Clock de 100 Hz
    output reg Hz1        // Saída de 1 Hz
);

reg [6:0] count = 7'b0000000; // Contador de 7 bits em binário

always @(posedge clk_100Hz) begin
    if (count == 7'b1100100) begin // 100 em binário
        count <= 7'b0; // Reinicia o contador quando atinge 100
        Hz1 <= ~Hz1; // Inverte o sinal a cada ciclo de clock para obter 1 Hz
    end else begin
        count <= count + 1; // Incrementa o contador
    end
end

endmodule
