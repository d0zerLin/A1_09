# A1_09 
# We first tried to use Verilog code for a simple matrix multiplier. The input matrixes are fixed size (2 by 2). So the output matrix is also fixed at 2 by 2. Both inputs and outputs are 32 bits, so each matrix unit consists of 8-bit binary number.
# Verilog doesn't allow you to have multi dimensional arrays as inputs or output ports. So we have converted the three dimensional input and output ports to one dimensional array. Inside the module we have created 3D temporary variables which are initialized to the inputs at the beginning of the always statement. 
# We also did a simple simulation, 
![Alt text](https://github.com/d0zerLin/A1_09/blob/main/1.png)
and the result turned out to be  
                                
