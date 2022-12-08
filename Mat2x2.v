`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/08 16:19:56
// Design Name: 
// Module Name: Mat2x2
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


module Mat2x2(A,B,S);

input [31:0]A;
input [31:0]B;
output wire [31:0]S;

assign S[7:0]= A[7:0]* B[7:0] +  A[15:8]* B[23:16];
assign S[15:8]=A[7:0]* B[15:8] +  A[15:8]* B[31:24];
assign S[23:16]= A[23:16]* B[7:0] +  A[31:24]* B[23:16];
assign S[31:24]= A[23:16]* B[15:8] +  A[31:24]* B[31:24];

endmodule
