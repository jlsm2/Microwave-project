module control_tb;

    reg startn, stopn, clearn, door_closed, timer_done;
  
  	wire mag_on;
    
    control dut (
        .startn(startn),
        .stopn(stopn),
        .clearn(clearn),
        .door_closed(door_closed),
        .timer_done(timer_done),
        .mag_on(mag_on)
    );
  
  	integer i;
    initial begin
    $dumpfile("control_tb.vcd");
    $dumpvars(0, control_tb);

      for (i = 0; i < 32; i = i + 1) begin
        startn = i[4];
        stopn = i[3];
        clearn = i[2];
        door_closed = i[1];
        timer_done = i[0];
      #10;
      end

    $finish;
  end
    
endmodule
