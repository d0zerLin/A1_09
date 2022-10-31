`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BU
// Engineer: dozer&jimmy
// 
// Create Date: 2022/10/25 20:10:15
// Design Name: 
// Module Name: two_by_two_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module two_by_two_tb();
reg [31:0] data1;
reg [31:0] data2;
wire [31:0] out;
two_by_two T1 (.data1(data1), .data2(data2), .out(out));

    initial begin
        data1 = 0;  data2 = 0;  #100;
        data1 = {8'd1,8'd2,8'd3,8'd4};
        data2 = {8'd5,8'd6,8'd7,8'd8}; //[ 1 2    ×    [ 5 6
                                       //  3 4 ]         7 8 ]
    end
      
endmodule
