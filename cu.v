module cu (clk, rst, start, done, matrix1WriteEn, mCounter1CountEn, mCounter1Zero, nCounter1CountEn, nCounter1Zero,
  matrix2WriteEn, nCounter2CountEn, nCounter2Zero, mCounter2CountEn, mCounter2Zero, sumRegWriteEn, sumRegZero,
  resMatrixWriteEn, resRowCounterCountEn, resColCounterCountEn, resRowCounterZero, resColCounterZero,mCounter1Value,
  nCounter1Value, mCounter2Value, nCounter2Value, resRowCounterValue, resColCounterValue);

  parameter N = 2-1;
  parameter M = 2-1;
  parameter DW = 8;
  parameter RW = 3 * DW;

  input clk, rst, start;
  input [DW-1:0] mCounter1Value, nCounter1Value, mCounter2Value, nCounter2Value, resRowCounterValue, resColCounterValue;

  output reg done, matrix1WriteEn, mCounter1CountEn, mCounter1Zero, nCounter1CountEn, nCounter1Zero,
   matrix2WriteEn, nCounter2CountEn, nCounter2Zero, mCounter2CountEn, mCounter2Zero, sumRegWriteEn, sumRegZero,
   resMatrixWriteEn, resRowCounterCountEn, resColCounterCountEn, resRowCounterZero, resColCounterZero;

  reg[4:0] ns, ps;
  parameter [4:0] IDLE=0, Starting=1, LoadFirstMatrix=2, LoadSecondMatrix=3, Computing=4, SaveResult=5, IncResRowCol=6, ComputationCompleted=7,
    DeliverResult=8;

  always @ (ps, start, nCounter1Value, nCounter2Value, mCounter1Value, mCounter2Value, resRowCounterValue, resColCounterValue) begin
    // ns <= ps;
    case(ps)
      IDLE: ns <= (start)? Starting : ps;
      Starting: ns <= (start)? ps : LoadFirstMatrix;
      LoadFirstMatrix: ns <= ((nCounter1Value == N) && (mCounter1Value == M))? LoadSecondMatrix : ps;
      LoadSecondMatrix: ns <= ((nCounter2Value == N) && (mCounter2Value == M))? Computing : ps;
      // Computing: ns <= ((nCounter2Value == N) && (mCounter2Value == M) && (nCounter1Value == N) && (mCounter1Value == M))? ComputationCompleted : ps;
      Computing: ns <= (nCounter1Value == N)? SaveResult : ps;
      SaveResult: ns <= IncResRowCol;
      IncResRowCol: ns<=((resRowCounterValue == M) && (resColCounterValue == M))? ComputationCompleted: Computing;
      ComputationCompleted: ns <= DeliverResult;
      DeliverResult: ns <= ((resRowCounterValue == M) && (resColCounterValue == M))? IDLE : ps;
    endcase
  end

  always @ (ps, nCounter1Value, nCounter2Value, mCounter1Value, mCounter2Value, resRowCounterValue, resColCounterValue) begin
    done <= 0; matrix1WriteEn <= 0; mCounter1CountEn <= 0; mCounter1Zero <= 0; nCounter1CountEn <= 0; nCounter1Zero <= 0;
    matrix2WriteEn <= 0; nCounter2CountEn <= 0; nCounter2Zero <= 0; mCounter2CountEn <= 0; mCounter2Zero <= 0; sumRegWriteEn <= 0; sumRegZero <= 0;
    resMatrixWriteEn <= 0; resRowCounterCountEn <= 0; resColCounterCountEn <= 0; resRowCounterZero <= 0; resColCounterZero <= 0;

    case(ps)
      IDLE: done <= 0;
      Starting: ;
      LoadFirstMatrix: begin
        mCounter1CountEn <= 1;
        matrix1WriteEn <= 1;
        if(mCounter1Value == M) begin
          nCounter1CountEn <= 1;
          mCounter1Zero <= 1;
        end
        if((nCounter1Value == N) && (mCounter1Value == M)) begin
          nCounter1Zero <= 1;
          mCounter1Zero <= 1;
        end
      end
      LoadSecondMatrix: begin
        nCounter2CountEn <= 1;
        matrix2WriteEn <= 1;
        if(nCounter2Value == N) begin
          nCounter2Zero <= 1;
          mCounter2CountEn <= 1;
        end
        if((mCounter2Value == M) && (nCounter2Value == N)) begin
          nCounter2Zero <= 1;
          mCounter2Zero <= 1;
        end
      end
      Computing: begin
        sumRegWriteEn <= 1;
        nCounter1CountEn <= 1;
        nCounter2CountEn <= 1;
        if (nCounter1Value == N) begin
          nCounter1Zero <= 1;
          nCounter2Zero <= 1;
          mCounter1CountEn <= 1;
        end
        if ((nCounter1Value == N) && (mCounter1Value == M) && (~(mCounter2Value == M))) begin
          mCounter2CountEn <= 1;
          mCounter1Zero <= 1;
        end
      end
      SaveResult: begin
        resMatrixWriteEn <= 1;
      end
      IncResRowCol: begin
        sumRegZero <= 1;
        resRowCounterCountEn <= 1;
        if(resRowCounterValue == M) resRowCounterZero <= 1;
        if(mCounter2Value > resColCounterValue) begin
          resColCounterCountEn <= 1;
        end
      end
      ComputationCompleted: begin
        resRowCounterZero <= 1;
        resColCounterZero <= 1;
      end
      DeliverResult: begin
        resRowCounterCountEn <= 1;
        done <= 1;
        if(resRowCounterValue == M) begin
          resRowCounterZero <= 1;
          resColCounterCountEn <= 1;
        end
      end
    endcase
  end

  always @ (posedge clk, posedge rst) begin
    if(rst) begin
      ps <= IDLE;
    end
    else begin
      ps <= ns;
    end
  end

endmodule // cu
