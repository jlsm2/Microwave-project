module counter_0_to_7_non_recycling (
    input wire rst,
    input wire clk,
    output reg out=0
);

    reg [2:0] cnt = 3'd0;
    reg counting = 0;

  always @ (posedge rst) begin
        if (cnt == 3'd7) begin
            counting = 0;
            cnt = 3'd0;
            out = 0;
        end
    end

  always @ (negedge rst) begin
        if (cnt == 3'd0) begin
            counting = 1;
        end
    end

    always @ (posedge clk) begin
        if (cnt < 3'd7 && counting == 1) begin
            cnt <= cnt + 1;
        end

        if(cnt == 3'd3) begin
            out <= 1;            
        end
    end
    
endmodule
