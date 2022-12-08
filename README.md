# Using Verilog to create a simple matrix multiplier
We first tried to use Verilog code for a simple matrix multiplier. The input matrices are fixed size (2 by 2). So the output matrix is also fixed at 2 by 2. Both inputs and outputs are 32 bits, so each matrix unit consists of 8-bit binary number.
Verilog doesn't allow you to have multi dimensional arrays as inputs or output ports. So we have converted the three dimensional input and output ports to one dimensional array. Inside the module we have created 3D temporary variables which are initialized to the inputs at the beginning of the always statement. 
We also did a simple simulation, using the behavioral simulation tool in Vivado, the inputs are:

![Alt text](https://github.com/d0zerLin/A1_09/blob/main/1.png) and ![Alt text](https://github.com/d0zerLin/A1_09/blob/main/2.png)

and the result turned out to be:

![Alt text](https://github.com/d0zerLin/A1_09/blob/main/3.png)
                                
# Code comment and simulation result
Matrix multiplier:

    //Module for calculating out = data1*data2. Where data1,data2 and out are 2 by 2 matrices.

    //input and output ports.

    //The size 32 bits which is 2*2=4 elements,each of which is 8 bits wide. 

    module two_by_two(data1,data2,out);   
    input [31:0] data1;
    input [31:0] data2;
    output [31:0] out; 
    
    //internal variables
    
    reg [31:0] out;
    reg [7:0] a1 [0:1][0:1];
    reg [7:0] b1 [0:1][0:1];
    reg [7:0] out1 [0:1][0:1]; 
    integer i,j,k;

    always@ (data1 or data2)
    begin
    
    //Initialize the matrices-convert 1 D to 3D arrays
    
        {a1[0][0],a1[0][1],a1[1][0],a1[1][1]} = data1;
        {b1[0][0],b1[0][1],b1[1][0],b1[1][1]} = data2;
        i = 0;
        j = 0;
        k = 0;
        {out1[0][0],out1[0][1],out1[1][0],out1[1][1]} = 32'd0; 
        //Matrix multiplication
        for(i=0;i < 2;i=i+1)
            for(j=0;j < 2;j=j+1)
                for(k=0;k < 2;k=k+1)
                    out1[i][j] = out1[i][j] + (a1[i][k] * b1[k][j]);
        //final output assignment - 3D array to 1D array conversion.    
        out = {out1[0][0],out1[0][1],out1[1][0],out1[1][1]};            
    end 
    endmodule

Testbench Code:

    module two_by_two_tb();
    reg [31:0] data1;
    reg [31:0] data2;
    wire [31:0] out;
    two_by_two T1 (.data1(data1), .data2(data2), .out(out));

    initial begin
    
        // Apply Inputs
        
        data1 = 0;  data2 = 0;  #100;
        data1 = {8'd1,8'd2,8'd3,8'd4};
        data2 = {8'd5,8'd6,8'd7,8'd8}; 
        
        //[ 1 2    ×    [ 5 6                                       
        //  3 4 ]         7 8 ]
        
    end      
    endmodule

Simulation waveform:

The codes were simulated using Xilinx Vivado. The following waveform verifies that the design is working correctly. 

![Alt text](https://github.com/d0zerLin/A1_09/blob/main/4.jpg)

This is the circuit Schematic of two_by_two matmul:

![Alt text](https://github.com/d0zerLin/A1_09/blob/main/5.jpg)




# Cannon Algorithm
To speed up matrix multiplication, we're going to try different algorithms. One of them is Cannon Algorithm.
When multiplying two n×n matrices A and B, we need n×n processing nodes p arranged in a 2D grid. Initially pi,j is responsible for ai,j and bi,j.
We need to select k in every iteration for every Processor Element (PE) so that processors don't access the same data for computing {\displaystyle a_{ik}*b_{kj}}{\displaystyle a_{ik}*b_{kj}}.
Therefore processors in the same row / column must begin summation with different indexes. If for example PE(0,0) calculates {\displaystyle a_{00}*b_{00}}{\displaystyle a_{00}*b_{00}} in the first step, PE(0,1) chooses {\displaystyle a_{01}*b_{11}}{\displaystyle a_{01}*b_{11}} first. The selection of k := (i + j) mod n for PE(i,j) satisfies this constraint for the first step.
In the first step we distribute the input matrices between the processors based on the previous rule.
In the next iterations we choose a new k' := (k + 1) mod n for every processor. This way every processor will continue accessing different values of the matrices. The needed data is then always at the neighbour processors. A PE(i,j) needs then the {\displaystyle a}a from PE(i,(j + 1) mod n) and the {\displaystyle b}b from PE((i + 1) mod n,j) for the next step. This means that {\displaystyle a}a has to be passed cyclically to the left and also {\displaystyle b}b cyclically upwards. The results of the multiplications are summed up as usual. After n steps, each processor has calculated all {\displaystyle a_{ik}*b_{kj}}{\displaystyle a_{ik}*b_{kj}} once and its sum is thus the searched {\displaystyle c_{ij}}c_{ij}.
After the initial distribution of each processor, only the data for the next step has to be stored. These are the intermediate result of the previous sum, a {\displaystyle a_{ik}}{\displaystyle a_{ik}} and a {\displaystyle b_{kj}}{\displaystyle b_{kj}}. This means that all three matrices only need to be stored in memory once evenly distributed across the processors.
As the picture showed below.

