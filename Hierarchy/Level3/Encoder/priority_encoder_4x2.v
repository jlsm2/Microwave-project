module priority_encoder_4x2(
    input enable,
    input [9:0] number,
    input clk,
    output reg [3:0] encoded
);

reg [9:0] number_reg;
reg [3:0] encoded_reg;
reg [3:0] debounce_counter;

always @(posedge clk) begin
    if (enable) begin
        number_reg <= number;
        case(number_reg)
            10'b0000000000: encoded_reg <= 4'b1111;
          	10'b1000000000: encoded_reg <= 4'b0000;
            10'b0100000000: encoded_reg <= 4'b0001;
            10'b0010000000: encoded_reg <= 4'b0010;
            10'b0001000000: encoded_reg <= 4'b0011;
            10'b0000100000: encoded_reg <= 4'b0100;
            10'b0000010000: encoded_reg <= 4'b0101;
            10'b0000001000: encoded_reg <= 4'b0110;
            10'b0000000100: encoded_reg <= 4'b0111;
            10'b0000000010: encoded_reg <= 4'b1000;
            10'b0000000001: encoded_reg <= 4'b1001;
        endcase
        if (debounce_counter < 4'd3) begin
            debounce_counter <= debounce_counter + 1;
        end else begin
            encoded <= encoded_reg;
        end
    end else begin
        encoded <= 4'b0000;
        number_reg <= 10'b0;
        debounce_counter <= 4'd0;
    end
end

endmodule
