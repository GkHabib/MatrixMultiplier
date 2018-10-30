module matrixMultiplier (clk, rst, start, done, inData, outData, overflow);
  parameter DW = 8;
  parameter RW = 3 * DW;

  input clk, rst, start;
  input [DW-1:0] inData;

  output overflow, done;
  output [DW-1:0] outData;

  wire matrix1WriteEnWire, mCounter1CountEnWire, mCounter1ZeroWire, nCounter1CountEnWire, nCounter1ZeroWire,
    matrix2WriteEnWire, nCounter2CountEnWire, nCounter2ZeroWire, mCounter2CountEnWire, mCounter2ZeroWire, sumRegWriteEnWire, sumRegZeroWire,
    resMatrixWriteEnWire, resRowCounterCountEnWire, resColCounterCountEnWire, resRowCounterZeroWire, resColCounterZeroWire;
  wire [DW-1:0] mCounter1ValueWire, nCounter1ValueWire, mCounter2ValueWire, nCounter2ValueWire, resRowCounterValueWire, resColCounterValueWire;

  cu CU_(.clk(clk), .rst(rst), .start(start), .done(done), .matrix1WriteEn(matrix1WriteEnWire), .mCounter1CountEn(mCounter1CountEnWire), .mCounter1Zero(mCounter1ZeroWire), .nCounter1CountEn(nCounter1CountEnWire), .nCounter1Zero(nCounter1ZeroWire),
    .matrix2WriteEn(matrix2WriteEnWire), .nCounter2CountEn(nCounter2CountEnWire), .nCounter2Zero(nCounter2ZeroWire), .mCounter2CountEn(mCounter2CountEnWire), .mCounter2Zero(mCounter2ZeroWire), .sumRegWriteEn(sumRegWriteEnWire), .sumRegZero(sumRegZeroWire),
    .resMatrixWriteEn(resMatrixWriteEnWire), .resRowCounterCountEn(resRowCounterCountEnWire), .resColCounterCountEn(resColCounterCountEnWire), .resRowCounterZero(resRowCounterZeroWire), .resColCounterZero(resColCounterZeroWire), .mCounter1Value(mCounter1ValueWire),
    .nCounter1Value(nCounter1ValueWire), .mCounter2Value(mCounter2ValueWire), .nCounter2Value(nCounter2ValueWire), .resRowCounterValue(resRowCounterValueWire), .resColCounterValue(resColCounterValueWire));

  dataPath DP_(.clk(clk), .rst(rst), .inData(inData), .outData(outData), .matrix1WriteEn(matrix1WriteEnWire), .mCounter1CountEn(mCounter1CountEnWire), .mCounter1Zero(mCounter1ZeroWire), .nCounter1CountEn(nCounter1CountEnWire), .nCounter1Zero(nCounter1ZeroWire),
    .matrix2WriteEn(matrix2WriteEnWire), .nCounter2CountEn(nCounter2CountEnWire), .nCounter2Zero(nCounter2ZeroWire), .mCounter2CountEn(mCounter2CountEnWire), .mCounter2Zero(mCounter2ZeroWire), .sumRegWriteEn(sumRegWriteEnWire), .sumRegZero(sumRegZeroWire),
    .resMatrixWriteEn(resMatrixWriteEnWire), .resRowCounterCountEn(resRowCounterCountEnWire), .resColCounterCountEn(resColCounterCountEnWire), .resRowCounterZero(resRowCounterZeroWire), .resColCounterZero(resColCounterZeroWire), .overflow(overflow),
    .mCounter1Value(mCounter1ValueWire), .nCounter1Value(nCounter1ValueWire), .mCounter2Value(mCounter2ValueWire), .nCounter2Value(nCounter2ValueWire), .resRowCounterValue(resRowCounterValueWire), .resColCounterValue(resColCounterValueWire));


endmodule // matrixMultiplier
