module MinutesSecondsTimer (
    input wire CLK,
    input wire Reset,
    output reg [3:0] seconds_units,
    output reg [2:0] seconds_tens,
    output reg [3:0] minutes_units
);

reg [2:0] sec_tens;
reg [3:0] sec_units;
reg [3:0] min_units;

always @ (posedge CLK) begin
    if (Reset) begin
        sec_tens <= 3'b101;
        sec_units <= 4'b1001;
        min_units <= 4'b1001;
    end else begin
      if (sec_tens == 3'b000 && sec_units == 4'b0000) begin
            min_units <= min_units - 1;
            sec_tens <= 3'b101;
            sec_units <= 4'b1001;
        end else if (sec_units == 4'b0000) begin
            sec_tens <= sec_tens - 1;
            sec_units <= 4'b1001;
        end else begin
            sec_units <= sec_units - 1;
        end
    end
  	assign seconds_units = sec_units;
	assign seconds_tens = sec_tens;
	assign minutes_units = min_units;
end

endmodule
