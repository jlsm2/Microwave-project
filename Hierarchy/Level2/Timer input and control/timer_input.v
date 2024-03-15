module timer_input (
    input wire clk,
    input wire rst,
    input wire [9:0] switches,
	 output reg [3:0] units_of_seconds,
	 output reg [3:0] units_of_minutes,
	 output reg [3:0] tens_of_seconds
);

// Internal signals
wire [3:0] encoded_input;
reg [3:0] last_input;
wire [2:0] counter;

// Instantiate modules

priority_encoder_4x2 encoder (
    .enable(1),
    .number(switches),
    .clk(clk),
    .encoded(encoded_input)
);

counter_0_to_7_non_recycling counter_inst (
    .clk(clk),
    .rst(rst),
    .count(counter)
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        last_input <= 4'b0000;
        units_of_seconds <= 4'b0000;
        units_of_minutes <= 4'b0000;
        tens_of_seconds <= 4'b0000;
    end else begin
        // Detect change in input
        if (encoded_input != last_input) begin
            // Update timer values
            tens_of_seconds <= units_of_seconds; // Fix this line
            units_of_minutes <= tens_of_seconds; // Move this line up
            units_of_seconds <= encoded_input;
            last_input <= encoded_input;
        end
    end
end

endmodule
