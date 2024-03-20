`include "mod10_counter.v"
`include "mod6_counter.v"

module MinutesSecondsTimer (
    input wire CLK,
    input wire Load,
    input wire Enable,
    input wire Clearn, // New input for clear signal
    input wire [3:0] initial_seconds_units, // New input for initial seconds units value
    input wire [2:0] initial_seconds_tens, // New input for initial seconds tens value
    input wire [3:0] initial_minutes_units, // New input for initial minutes units value
    output reg [3:0] seconds_units,
    output reg [2:0] seconds_tens,
    output reg [3:0] minutes_units,
    output reg timer_done
);

reg [3:0] min_counter;
reg [3:0] seconds_units_load; // New register to hold the initial seconds units value
reg [2:0] seconds_tens_load; // New register to hold the initial seconds tens value
reg [3:0] minutes_units_load; // New register to hold the initial minutes units value

wire [3:0] sec_units_counter;
wire [2:0] min_counter_output;

mod10_counter mod10 (
    .CLK(CLK),
    .Q(sec_units_counter)
);

mod6_counter mod6 (
    .CLK(CLK),
    .Q(min_counter_output)
);

always @ (posedge CLK) begin
    if (!Clearn) begin
        // Set all outputs to zero when Clearn is zero
        seconds_units <= 4'b0000;
        seconds_tens <= 3'b000;
        minutes_units <= 4'b0000;
        timer_done <= 1'b0;
    end else if (Load) begin
        // Load initial values when Load is high
        seconds_units <= initial_seconds_units; // Load initial seconds units
        seconds_tens <= initial_seconds_tens; // Load initial seconds tens
        minutes_units <= initial_minutes_units; // Load initial minutes units
        seconds_units_load <= initial_seconds_units; // Save initial seconds units
        seconds_tens_load <= initial_seconds_tens; // Save initial seconds tens
        minutes_units_load <= initial_minutes_units; // Save initial minutes units
    end else if (Enable && !(minutes_units == 4'b0000 && seconds_tens == 3'b000 && seconds_units == 4'b0000)) begin
        // Only count down if Enable is high and timer is not already at 0:00
        if (seconds_tens == 3'b000 && seconds_units == 4'b0000) begin
            minutes_units <= minutes_units - 1;
            seconds_tens <= 3'b101;
            seconds_units <= 4'b1001;
        end else if (seconds_units == 4'b0000) begin
            seconds_tens <= seconds_tens - 1;
            seconds_units <= 4'b1001;
        end else begin
            seconds_units <= seconds_units - 1;
        end
    end
    // Set timer_done to 1 when timer is 0:00, and to 0 otherwise
    if (minutes_units == 4'b0000 && seconds_tens == 3'b000 && seconds_units == 4'b0000) begin
        timer_done <= 1'b1;
    end else begin
        timer_done <= 1'b0;
    end
end

endmodule
