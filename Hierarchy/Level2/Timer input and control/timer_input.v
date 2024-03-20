module timer_input (
    input wire clk,
    input wire enablen, // Changed from rst to enablen
    input wire [9:0] switches,
    output reg [3:0] units_of_seconds,
    output reg [3:0] units_of_minutes,
    output reg [3:0] tens_of_seconds,
    output reg loadn,
    output wire pgt_1Hz
);

// Internal signals
wire [3:0] encoded_input;
reg [3:0] last_input;
wire [2:0] counter;
wire mux_a;
wire mux_b;

// Instantiate modules

priority_encoder_4x2 encoder (
  .enable(1'b1),
    .number(switches),
    .clk(clk),
  .encoded(encoded_input)
);

counter_0_to_7_non_recycling counter_inst (
    .clk(clk),
    .rst(enablen), // Changed from rst to enablen
  .count(counter),
  .out(mux_a)
);
 
ContadorFreq100 cf( 
  .clk_100Hz(clk),
  .Hz1(mux_b) 
  );

 mux2_to_1 mux(
   .a(mux_a), 
   .b(mux_b), 
   .sel(enablen), 
   .Q(pgt_1Hz));

always @(posedge clk or posedge ~enablen) begin // Changed from rst to enablen
    if (~enablen) begin // Changed from rst to enablen
        last_input <= encoded_input;
        units_of_seconds <= 4'b0000;
        units_of_minutes <= 4'b0000;
        tens_of_seconds <= 4'b0000;
        loadn <= 1'b0; // Added loadn output
    end else begin
        // Detect change in input
        if (encoded_input != last_input ) begin
            // Update timer values
            if(encoded_input != 4'b1111) begin
                tens_of_seconds <= units_of_seconds;
                units_of_minutes <= tens_of_seconds;
                units_of_seconds <= encoded_input;
            end
            last_input <= encoded_input;
            loadn <= 1'b1; // Added loadn output
        end
    end
end

endmodule
