module sumReg (clk, rst, writeEn, zero, in, out);
  parameter DW = 8;
  parameter RW = 3 * DW;

  input clk, rst, writeEn, zero;
  input [RW-1:0] in;
  output reg [RW-1:0] out;

  always @ (posedge clk, posedge rst) begin
    if(rst) begin
      out <= 0;
    end
    else begin
      if(zero) begin
        out <= 0;
      end
      else begin
        if(writeEn) begin
          out <= in;
        end
      end
    end
  end
endmodule // sumReg
