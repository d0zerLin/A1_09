`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BU
// Engineer: jimmy&dozer
// 
// Create Date: 2022/10/25 19:58:30
// Design Name: 2 by 2 matmal
// Module Name: two_by_two
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


module two_by_two(data1,data2,out);   
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] out;   
    reg [31:0] out;
    reg [7:0] a1 [0:1][0:1];
    reg [7:0] b1 [0:1][0:1];
    reg [7:0] out1 [0:1][0:1]; 
    integer i,j,k;

    always@ (data1 or data2)
    begin
        {a1[0][0],a1[0][1],a1[1][0],a1[1][1]} = data1;
        {b1[0][0],b1[0][1],b1[1][0],b1[1][1]} = data2;
        i = 0;
        j = 0;
        k = 0;
        {out1[0][0],out1[0][1],out1[1][0],out1[1][1]} = 32'd0; 

        for(i=0;i < 2;i=i+1)
            for(j=0;j < 2;j=j+1)
                for(k=0;k < 2;k=k+1)
                    out1[i][j] = out1[i][j] + (a1[i][k] * b1[k][j]);
            
        out = {out1[0][0],out1[0][1],out1[1][0],out1[1][1]};            
    end 

endmodule
