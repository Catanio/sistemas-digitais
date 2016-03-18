module toplevel;
  wire luz;
  wire sgn;
  wire [25:0] cnt;
  count C(CLOCK_50, sgn, cnt);
  count_check CC(cnt,sgn);
  led_reg LR(sgn, LEDG);
endmodule

module count (input clock, input sign, output [25:0] count);
  reg [25:0] reg_count = 0;
  assign count = reg_count;

  always @(posedge clock) begin
    if (sign == 1) begin
      reg_count <= 0;
    end else begin
      reg_count <= reg_count + 1;
    end
    end
endmodule

module count_check (input [25:0] count, output sign);

  reg sign_reg = 0;
  assign sign = sign_reg;
  always @(count) begin
    case (count)
      10: sign_reg <=1;
      default : sign_reg <=0;
    endcase
  end
endmodule

module led_reg (input onoff, output sign);
  reg luz_reg = 0;
  assign sign = luz_reg;
  always @(posedge onoff) luz_reg <= ~luz_reg;
endmodule



/*
module teste;
  reg clk = 0;
  always #2 clk<= ~clk;
  wire luz;
  wire sgn;
  wire [25:0] cnt;
  count C(clk, sgn, cnt);
  count_check CC(cnt,sgn);
  led_reg LR(sgn, luz);

  initial begin
    $dumpvars (0, C, CC, LR, luz);
      #5000
    $finish;
  end
endmodule*/
