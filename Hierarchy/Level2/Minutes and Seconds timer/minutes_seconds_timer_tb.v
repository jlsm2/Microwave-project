`include "MinutesSecondsTimer.v"
`timescale 1s/1s

module MinutesSecondsTimer_tb;

    reg CLK;
    reg Reset;
    reg Load; // New Load input
    reg Enable; // New Enable input

    wire [3:0] seconds_units;
    wire [2:0] seconds_tens;
    wire [3:0] minutes_units;
    wire timer_done; // New timer_done output

    MinutesSecondsTimer uut (
        .CLK(CLK),
        .Reset(Reset),
        .Load(Load), // Connect Load input
        .Enable(Enable), // Connect Enable input
        .seconds_units(seconds_units),
        .seconds_tens(seconds_tens),
        .minutes_units(minutes_units),
        .timer_done(timer_done) // Connect timer_done output
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
        Load = 1; // Load initial values
        Enable = 0; // Don't start the timer yet

        #10 Reset = 0;
        Load = 0; // Stop loading initial values
        Enable = 1; // Start the timer

        #200 Reset = 1;
        Load = 1; // Load initial values again
        Enable = 0; // Stop the timer

        #50 Reset = 0;
        Load = 0; // Stop loading initial values
        Enable = 1; // Start the timer again

        #6100 $finish;
    end

endmodule
