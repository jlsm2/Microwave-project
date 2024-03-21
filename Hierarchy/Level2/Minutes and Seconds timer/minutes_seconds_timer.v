module minutes_seconds_timer (
    input wire CLK,
    input wire Load,
    input wire Enable,
    input wire Clearn,
    input wire [3:0] initial_seconds_units,
    input wire [3:0] initial_seconds_tens,
    input wire [3:0] initial_minutes_units,
    output reg [3:0] seconds_units,
    output reg [3:0] seconds_tens,
    output reg [3:0] minutes_units,
    output reg timer_done
);

reg [3:0] min_counter;
wire [3:0] sec_units_counter;
wire [3:0] min_counter_output;

mod10_counter mod10 (
    .CLK(CLK),
    .Q(sec_units_counter)
);

mod6_counter mod6 (
    .CLK(CLK),
    .Q(min_counter_output)
);

always @ (posedge CLK) begin
	 if ((minutes_units == 4'b0000) && (seconds_tens == 4'b0000) && (seconds_units == 4'b0000)) begin
        timer_done <= 1'b1;
    end else begin
        timer_done <= 1'b0;
    end
		  
    if (!Clearn) begin
        seconds_units <= 4'b1111;
        seconds_tens <= 4'b1111;
        minutes_units <= 4'b1111;
        //assign initial_seconds_units = 4'b1111;
        //assign initial_seconds_tens = 4'b1111;
        //assign initial_minutes_units = 4'b1111;
    end else if (Load) begin
        seconds_units <= initial_seconds_units;
        seconds_tens <= initial_seconds_tens;
        minutes_units <= initial_minutes_units;
    end else if (Enable && !(minutes_units == 4'b0000 && seconds_tens == 4'b0000 && seconds_units == 4'b0000)) begin
				if (minutes_units > 4'b1001) begin
					minutes_units <= 4'b0000;
			  end
			  if (seconds_units > 4'b1001) begin
					seconds_units <= 4'b0000;
			  end
			  if (seconds_tens > 4'b1001) begin
					seconds_tens <= 4'b0000;
			  end
        if (seconds_tens == 4'b0000 && seconds_units == 4'b0000 && minutes_units < 4'b1001) begin
            minutes_units <= minutes_units - 1;
            seconds_tens <= 4'b0101;
            seconds_units <= 4'b1001;
        end else if (seconds_units == 4'b0000 && seconds_tens < 4'b1001) begin
            seconds_tens <= seconds_tens - 1;
            seconds_units <= 4'b1001;
        end else begin
				if (seconds_units < 4'b1001) begin
					seconds_units <= seconds_units - 1;
				end
        end
    end
	 
end

endmodule
