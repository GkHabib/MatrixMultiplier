module resMatrix (clk, rst, writeEn, in, outData, outOf, rowSel, colSel);
  parameter M = 2;
  parameter DW = 8;
  parameter RW = 3 * DW;

  input clk, rst, writeEn;
  input [RW-1:0] in;
  output [RW-DW-1:0] outOf;
  output [DW-1:0] outData;
  input [DW-1:0] rowSel, colSel;
  reg [RW-1:0] memArr[M-1:0][M-1:0];
always @ (posedge clk, posedge rst) begin
  if(rst) begin
  //
  end
  else begin
    if(writeEn) begin
      memArr[rowSel][colSel] <= in;
    end
  end
end

assign outData = memArr[rowSel][colSel][DW-1:0];
assign outOf = memArr[rowSel][colSel][RW-1:DW];

endmodule // resMatrix
