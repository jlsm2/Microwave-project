`include "a.sv"
`include "b.sv"
`include "c.sv"
`include "d.sv"
`include "e.sv"
module timer_input (
    input wire clk,
    input wire enablen,
    input wire [9:0] switches,
    output reg [3:0] units_of_seconds,
    output reg [3:0] units_of_minutes,
    output reg [3:0] tens_of_seconds,
    output reg loadn,
    output wire pgt_1Hz
);

wire [3:0] encoded_input;
reg [3:0] last_input;
wire mux_a;
wire mux_b;
wire int_clr;

priority_encoder_4x2 encoder (
    .enable(enablen),
    .number(switches),
    .clk(clk),
  .encoded(encoded_input),
  .all_off(int_clr)
);

counter_0_to_7_non_recycling counter_inst (
    .clk(clk),
  .rst(int_clr),
  .out(mux_a)
);
 
f100 cf( 
   .clk_100Hz(clk),
   .Hz1(mux_b) 
);

 mux2_to_1 mux(
   .a(mux_a), 
   .b(mux_b), 
   .sel(enablen), 
   .Q(pgt_1Hz)
);

always @(posedge clk) begin
	 if (~enablen) begin
        last_input <= encoded_input;
        units_of_seconds <= 4'b1111;
        units_of_minutes <= 4'b1111;
        tens_of_seconds <= 4'b1111;
        loadn <= 1'b0;
    end else begin
        if (encoded_input != last_input) begin
            if(encoded_input != 4'b1111) begin
                tens_of_seconds <= units_of_seconds;
                units_of_minutes <= tens_of_seconds;
                units_of_seconds <= encoded_input;
            end
            last_input <= encoded_input;
            loadn <= 1'b1;
        end
    end
end

endmodule
