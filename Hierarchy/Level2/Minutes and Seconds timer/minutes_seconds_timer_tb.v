`timescale 1s/1s

module MinutesSecondsTimer_tb;

    reg CLK;
    reg Load;
    reg Enable;
    reg Clearn; // New input for clear signal
    reg [3:0] initial_seconds_units; // New input for initial seconds units value
    reg [2:0] initial_seconds_tens; // New input for initial seconds tens value
    reg [3:0] initial_minutes_units; // New input for initial minutes units value

    wire [3:0] seconds_units;
    wire [2:0] seconds_tens;
    wire [3:0] minutes_units;
    wire timer_done;

    MinutesSecondsTimer uut (
        .CLK(CLK),
        .Load(Load),
        .Enable(Enable),
        .Clearn(Clearn), // Connect clear signal
        .initial_seconds_units(initial_seconds_units), // Connect initial seconds units input
        .initial_seconds_tens(initial_seconds_tens), // Connect initial seconds tens input
        .initial_minutes_units(initial_minutes_units), // Connect initial minutes units input
        .seconds_units(seconds_units),
        .seconds_tens(seconds_tens),
        .minutes_units(minutes_units),
        .timer_done(timer_done)
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
        Load = 1;
        Enable = 0;
        Clearn = 1; // Initially, Clearn is high

        // Load initial values
        initial_seconds_units = 4'b0111;
        initial_seconds_tens = 3'b101; 
        initial_minutes_units = 4'b1000; 

        #10
        Load = 0;
        Enable = 1;

        #200
        Load = 1;
        Enable = 0;

        #50
        Load = 0;
        Enable = 1;

        #5000
        Clearn = 0; // Clear the timer
        #10
        Clearn = 1; // Set Clearn back to high

        #6100 $finish;
    end

endmodule
