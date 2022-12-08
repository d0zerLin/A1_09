`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/08 16:20:17
// Design Name: 
// Module Name: Matrix4x4
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


module Matrix4x4( clk,  A, B,  S);
input clk;

input [7:0] A[0:3][0:3];
input [7:0] B[0:3][0:3];
reg [127:0]tempA;
reg [127:0]tempB;
reg [127:0]tempS;
reg [127:0]result = 0;
reg [31:0]clkdiv = 0;
reg [3:0]State = 0;
output reg [7:0] S[0:3][0:3];
integer i = 0;
integer j = 0;
// 4 x 2x2 matrix multiplier
Mat2x2 m1(tempA[31:0] ,tempB[31:0] ,tempS[31:0] );
Mat2x2 m2(tempA[63:32], tempB[63:32] ,tempS[63:32]);
Mat2x2 m3(tempA[95:64], tempB[95:64] ,tempS[95:64]);
Mat2x2 m4(tempA[127:96],tempB[127:96],tempS[127:96]);
// clock divider
always@(posedge clk)begin
    clkdiv <= 1'b1 + clkdiv;
end
always@(posedge clkdiv[2])begin
    case(State)
        0: begin 
        //initial
                tempB[31:0] <= {B[1][1],B[1][0],B[0][1],B[0][0]}    ;
                tempB[63:32] <={B[1][3],B[1][2],B[0][3],B[0][2]}   ;
                tempB[95:64] <= {B[1][1],B[1][0],B[0][1],B[0][0]} ; 
                tempB[127:96] <={B[1][3],B[1][2],B[0][3],B[0][2]}    ;
                tempA[31:0] <= {A[1][1],A[1][0],A[0][1],A[0][0]};
                tempA[63:32] <= {A[1][1],A[1][0],A[0][1],A[0][0]};  
                tempA[95:64] <= {A[3][1],A[3][0],A[2][1],A[2][0]};
                tempA[127:96]<=  {A[3][1],A[3][0],A[2][1],A[2][0]};
                State <= State + 1;
        end
        // 第一项加入 因为单个元素只有8位，因此不能直接128位一起加，而要8位8位的加
        1: begin
            result[7:0]     <= result [7:0]     + tempS[7:0]     ;
            result[15:8]    <= result [15:8]    + tempS[15:8]    ;
            result[23:16]   <= result [23:16]   + tempS[23:16]   ;
            result[31:24]   <= result [31:24]   + tempS[31:24]   ;
            result[39:32]   <= result [39:32]   + tempS[39:32]   ;
            result[47:40]    <=result [47:40]   + tempS[47:40]   ;
            result[55:48]   <= result [55:48]   + tempS[55:48]   ;
            result[63:56]   <= result [63:56]   + tempS[63:56]   ;
            result[71:64]   <= result [71:64]   + tempS[71:64]   ;
            result[79:72]    <=result [79:72]   + tempS[79:72]   ;
            result[87:80]   <= result [87:80]   + tempS[87:80]   ;
            result[95:88]   <= result [95:88]   + tempS[95:88]   ;
            result[103:96]   <=result [103:96]  + tempS[103:96]  ;
            result[111:104] <= result [111:104] + tempS[111:104] ;
            result[119:112] <= result [119:112] + tempS[119:112] ;
            result[127:120] <= result [127:120] + tempS[127:120] ;


            State <= State + 1;
        end
        // shift 1 block 2x2块移位通过直接写对应索引得到
        2: begin
            tempB[31:0] <= {B[3][1],B[3][0],B[2][1],B[2][0]};
            tempB[63:32] <= {B[3][3],B[3][2],B[2][3],B[2][2]};
            tempB[95:64] <= {B[3][1],B[3][0],B[2][1],B[2][0]};
            tempB[127:96] <=  {B[3][3],B[3][2],B[2][3],B[2][2]};
            tempA[31:0] <= {A[1][3],A[1][2],A[0][3],A[0][2]};
            tempA[63:32] <= {A[1][3],A[1][2],A[0][3],A[0][2]};
            tempA[95:64] <={A[3][3],A[3][2],A[2][3],A[2][2]};
            tempA[127:96]<=  {A[3][3],A[3][2],A[2][3],A[2][2]};
            State <= State +1;
        end
        3: begin
			// 第二项加入
            result[7:0]     <= result [7:0]     + tempS[7:0]     ;
            result[15:8]    <= result [15:8]    + tempS[15:8]    ;
            result[23:16]   <= result [23:16]   + tempS[23:16]   ;
            result[31:24]   <= result [31:24]   + tempS[31:24]   ;
            result[39:32]   <= result [39:32]   + tempS[39:32]   ;
            result[47:40]    <=result [47:40]   + tempS[47:40]   ;
            result[55:48]   <= result [55:48]   + tempS[55:48]   ;
            result[63:56]   <= result [63:56]   + tempS[63:56]   ;
            result[71:64]   <= result [71:64]   + tempS[71:64]   ;
            result[79:72]    <=result [79:72]   + tempS[79:72]   ;
            result[87:80]   <= result [87:80]   + tempS[87:80]   ;
            result[95:88]   <= result [95:88]   + tempS[95:88]   ;
            result[103:96]   <=result [103:96]  + tempS[103:96]  ;
            result[111:104] <= result [111:104] + tempS[111:104] ;
            result[119:112] <= result [119:112] + tempS[119:112] ;
            result[127:120] <= result [127:120] + tempS[127:120] ;
            State <= State +1;
        end
        4: begin
            //result 移位输入到S寄存器中
            for(i = 0;i<2;i=i+1)begin
                for(j=0;j<2;j=j+1)begin
                    #5
                    S[i*2+0][j*2+0] <= result[7:0];
                    S[i*2+0][j*2+1] <= result[15:8];
                    S[i*2+1][j*2+0] <= result[23:16];
                    S[i*2+1][j*2+1] <= result[31:24];
                    #5 result <= (result>>32);
                end
            end
            State<=State+1;
        end
        
        endcase
end

endmodule
