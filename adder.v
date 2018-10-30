module adder (in1, in2, out);
  parameter DW = 8;
  parameter RW = 3 * DW;

  input[RW-1:0] in1, in2;
  output [RW-1:0] out;

  assign out = in1 + in2;
endmodule // adder
