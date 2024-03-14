`include "mod10_counter.v"
`include "mod6_counter.v"

module MinutesSecondsTimer (
    input wire CLK,
    input wire Reset,
    output reg [3:0] seconds_units,
    output reg [2:0] seconds_tens,
    output reg [3:0] minutes_units
);

//reg [3:0] seconds_units; // Redefining sec_units for better clarity

reg [3:0] min_counter; // New register to hold the minutes counter value

wire [3:0] sec_units_counter; // Output of the mod10 counter
wire [2:0] min_counter_output; // Output of the mod6 counter

mod10_counter mod10 (
    .CLK(CLK),
    .Reset(Reset),
    .Q(sec_units_counter)
);

mod6_counter mod6 (
    .CLK(CLK),
    .Reset(Reset),
    .Q(min_counter_output)
);

always @ (posedge CLK) begin
    if (Reset) begin
        seconds_units <= 4'b1001; // Reset seconds to 59
        seconds_tens <= 3'b101; // Reset tens to 5
        minutes_units <= 4'b1001; // Reset minutes to 9
    end else begin
        if (seconds_tens == 3'b000 && seconds_units == 4'b0000) begin
            minutes_units <= minutes_units - 1; // Decrement minutes
            seconds_tens <= 3'b101; // Reset tens to 5
            seconds_units <= 4'b1001; // Reset seconds to 59
        end else if (seconds_units == 4'b0000) begin
            seconds_tens <= seconds_tens - 1; // Decrement tens
            seconds_units <= 4'b1001; // Reset seconds to 59
        end else begin
            seconds_units <= seconds_units - 1; // Decrement seconds
        end
    end
    //seconds_units = sec_units; // Assign seconds units directly from sec_units register
end

endmodule