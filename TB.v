`timescale 1ns/1ns

module TB();

parameter N = 2;
parameter M = 2;
parameter DW = 8;
parameter RW = 3 * DW;

reg start, clk, rst;
wire done, overflow;
reg [DW-1:0] inData;
wire [DW-1:0] outData;

matrixMultiplier DUT_(.clk(clk), .rst(rst), .start(start), .done(done), .inData(inData), .outData(outData), .overflow(overflow));

initial begin
clk = 0; rst = 0; inData = 0; start = 0;
#100 begin rst = 1; end
#100 begin rst = 0; end
#100 begin start = 1; end
#100 begin clk = 1; end
#100 begin clk = 0; end
#100 begin start = 0; end
#100 begin clk = 1; end
#100 begin clk = 0; end
#100 begin clk=1; inData = 2; end
#100 begin clk=0; end
#100 begin clk=1; inData = 5; end
#100 begin clk=0; end
#100 begin clk=1; inData = 1; end
#100 begin clk=0; end
#100 begin clk=1; inData = 3; end
#100 begin clk=0; end
#100 begin clk=1; inData = 1; end
#100 begin clk=0; end
#100 begin clk=1; inData = 4; end
#100 begin clk=0; end
#100 begin clk=1; inData = 2; end
#100 begin clk=0; end
#100 begin clk=1; inData = 2; end
#100 begin clk=0; end
repeat (100) #100 clk=~clk;
end

endmodule // TB
