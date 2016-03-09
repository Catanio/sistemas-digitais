module pisca (input clock, output luz);
  assign luz = clock;

endmodule
module testclock;
  reg clock;
  wire luz;
  always #5 clock = ~clock;//# é arbitrário?
  pisca A(clock, luz);
  initial begin
    $dumpvars(0, A);
    clock <= 0;
    #500;
    $finish;
  end

endmodule
