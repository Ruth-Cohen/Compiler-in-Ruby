// This file is part of the materials accompanying the book 
// "The Elements of Computing Systems" by Nisan and Schocken, 
// MIT Press. Book site: www.idc.ac.il/tecs
// File name: projects/08/FunctionCalls/SimpleFunction/SimpleFunction.vm

// Performs a simple calculation and returns the result.
// function
(SimpleFunction.test)
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop local 0
@SP
A=M-1
D=M
@LCL
A=M
M=D
@SP
M=M-1
//push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//pop local 1
@SP
A=M-1
D=M
@LCL
A=M
A=A+1
M=D
@SP
M=M-1
// push local 0
@LCL
D=M
@0
A=A+D
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 1
@LCL
D=M
@1
A=A+D
D=M
@SP
A=M
M=D
@SP
M=M+1
// add
@SP
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1
// notS
@SP
A=M-1
M=!M
// push argument 0
@ARG
D=M
@0
A=A+D
D=M
@SP
A=M
M=D
@SP
M=M+1
// add
@SP
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1
// push argument 1
@ARG
D=M
@1
A=A+D
D=M
@SP
A=M
M=D
@SP
M=M+1
// sub
@SP
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1
// Return
//save start of local of the current
@LCL
D=M
@R13
M=D
//put the return addrs in a temporary variable
@R13
A=M
A=A-1
A=A-1
A=A-1
A=A-1
A=A-1
D=M
@R14
M=D
//reposition the return value for the caller func
@SP
A=M
A=A-1
D=M
@ARG
A=M
M=D
//restore SP of the caller
@ARG
D=M+1
@SP
M=D
//restore THAT of the caller
@R13
A=M
A=A-1
D=M
@THAT
M=D
//restore THIS of the caller
@R13
A=M
A=A-1
A=A-1
D=M
@THIS
M=D
//restore ARG of the caller
@R13
A=M
A=A-1
A=A-1
A=A-1
D=M
@ARG
M=D
//restore LCL of the caller
@R13
A=M
A=A-1
A=A-1
A=A-1
A=A-1
D=M
@LCL
M=D
//goto return address(RAM[13])
@R14
A=M
0;JMP
