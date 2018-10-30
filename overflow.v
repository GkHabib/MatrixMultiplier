module overflow (in, out);

  parameter DW = 8;
  parameter RW = 3 * DW;

  input [RW-DW-1:0] in;
  output out;

  assign out = |(in);

endmodule // overflow
