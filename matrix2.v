module matrix2 (clk, rst, writeEn, in, out, rowSel, colSel);
  parameter M = 2;
  parameter N = 2;
  parameter DW = 8;

  input clk, rst, writeEn;
  input [DW-1:0] in;
  output [DW-1:0] out;
  input [DW-1:0] rowSel, colSel;
  reg [DW-1:0] memArr[N-1:0][M-1:0];
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

assign out = memArr[rowSel][colSel];

endmodule // matrix2
