module dataPath (clk, rst, inData, outData, matrix1WriteEn, mCounter1CountEn, mCounter1Zero, nCounter1CountEn, nCounter1Zero,
   matrix2WriteEn, nCounter2CountEn, nCounter2Zero, mCounter2CountEn, mCounter2Zero, sumRegWriteEn, sumRegZero,
   mCounter1Value, nCounter1Value, mCounter2Value, nCounter2Value, resRowCounterValue, resColCounterValue, overflow,
   resMatrixWriteEn, resRowCounterCountEn, resColCounterCountEn, resRowCounterZero, resColCounterZero);

   parameter DW = 8;
   parameter RW = 3 * DW;

   input [DW-1:0] inData;
   input clk, rst, matrix1WriteEn, mCounter1CountEn, mCounter1Zero, nCounter1CountEn, nCounter1Zero,
   matrix2WriteEn, nCounter2CountEn, nCounter2Zero, mCounter2CountEn, mCounter2Zero, sumRegWriteEn, sumRegZero, resMatrixWriteEn,
   resRowCounterCountEn, resColCounterCountEn, resRowCounterZero, resColCounterZero;

   output overflow;
   output [DW-1:0] mCounter1Value, nCounter1Value, mCounter2Value, nCounter2Value, resRowCounterValue, resColCounterValue;
   output [DW-1:0] outData;

   wire [DW-1:0] matrix1OutData, matrix2OutData;
   wire [RW-1:0] multOutData, addOutData, sumRegOutData;
   wire [DW-1:0] mCounter1OutData, nCounter1OutData, mCounter2OutData, nCounter2OutData, resRowCounterOutData, resColCounterOutData;
   wire [RW-DW-1:0] resMatrixOutDataOF;
   matrix1 MTRX1_(.clk(clk), .rst(rst), .writeEn(matrix1WriteEn), .in(inData), .out(matrix1OutData), .rowSel(mCounter1OutData), .colSel(nCounter1OutData));
   counterM mCOUNTER1_(.clk(clk), .rst(rst), .countEn(mCounter1CountEn), .zeroM(mCounter1Zero), .out(mCounter1OutData));
   counterN nCOUNTER1_(.clk(clk), .rst(rst), .countEn(nCounter1CountEn), .zeroM(nCounter1Zero), .out(nCounter1OutData));

   matrix2 MTRX2_(.clk(clk), .rst(rst), .writeEn(matrix2WriteEn), .in(inData), .out(matrix2OutData), .rowSel(nCounter2OutData), .colSel(mCounter2OutData));
   counterN nCOUTNER2_(.clk(clk), .rst(rst), .countEn(nCounter2CountEn), .zeroM(nCounter2Zero), .out(nCounter2OutData));
   counterM mCOUTNER2_(.clk(clk), .rst(rst), .countEn(mCounter2CountEn), .zeroM(mCounter2Zero), .out(mCounter2OutData));

   mult MULT_(.in1(matrix1OutData), .in2(matrix2OutData), .out(multOutData));
   adder ADDER_(.in1(multOutData), .in2(sumRegOutData), .out(addOutData));
   sumReg SUMREG_(.clk(clk), .rst(rst), .writeEn(sumRegWriteEn), .zero(sumRegZero), .in(addOutData), .out(sumRegOutData));

   resMatrix RESMTRX_(.clk(clk), .rst(rst), .writeEn(resMatrixWriteEn), .in(sumRegOutData), .outData(outData), .outOf(resMatrixOutDataOF), .rowSel(resRowCounterOutData), .colSel(resColCounterOutData));
   counterM RESRowCOUNTER_(.clk(clk), .rst(rst), .countEn(resRowCounterCountEn), .zeroM(resRowCounterZero), .out(resRowCounterOutData));
   counterM RESColCOUNTER_(.clk(clk), .rst(rst), .countEn(resColCounterCountEn), .zeroM(resColCounterZero), .out(resColCounterOutData));

   overflow OF_(.in(resMatrixOutDataOF), .out(overflow));

   assign mCounter1Value = mCounter1OutData;
   assign mCounter2Value = mCounter2OutData;
   assign nCounter1Value = nCounter1OutData;
   assign nCounter2Value = nCounter2OutData;
   assign resRowCounterValue = resRowCounterOutData;
   assign resColCounterValue = resColCounterOutData;

endmodule // dataPath
