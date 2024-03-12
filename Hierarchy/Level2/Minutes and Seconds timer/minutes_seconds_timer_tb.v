`include "MinutesSecondsTimer.v"
`timescale 1s/1s

module MinutesSecondsTimer_tb;

    reg CLK;
    reg Reset;

    wire [3:0] seconds_units;
    wire [2:0] seconds_tens;
    wire [3:0] minutes_units;

    MinutesSecondsTimer uut (
        .CLK(CLK),
        .Reset(Reset),
        .seconds_units(seconds_units),
        .seconds_tens(seconds_tens),
        .minutes_units(minutes_units)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end

    always begin
        CLK = 1;
        #5 CLK = 0;
        #5;
    end

    initial begin
        Reset = 1;

        #10 Reset = 0;

        #200 Reset = 1;

        #50 Reset = 0;

        #5990 $finish;
    end

endmodule
