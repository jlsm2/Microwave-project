`timescale 1ns / 1ps

module ContadorFreq100_tb;

    reg clk_100Hz;
    wire Hz1;

    ContadorFreq100 UUT (
        .clk_100Hz(clk_100Hz), 
        .Hz1(Hz1)
    );

    initial begin
        clk_100Hz = 0;

        $dumpfile("ContadorFreq100.vcd");
        $dumpvars(0, ContadorFreq100_tb);

        #100;

        repeat (100) begin
            #10 clk_100Hz = ~clk_100Hz;
        end

        $finish;
    end

endmodule
