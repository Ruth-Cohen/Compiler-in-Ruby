//init stack
@256
D=A
@SP
M=D
//call sys.init
// push return address
@Sys.init.return_address0
D=A
@SP
A=M
M=D
@SP
M=M+1
//save LCL of the calling funcyion
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
//save ARG of the calling function
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
//save THIS of the calling function
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
//save THAT of the calling function
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
//reposition ARG
@SP
D=M
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@0
D=D-A
@ARG
M=D
//reposition LCL
@SP
D=M
@LCL
M=D
//transfer control
@Sys.init
0;JMP
//Declare a label for the return-address
(Sys.init.return_address0)
// This file is part of the materials accompanying the book 
// "The Elements of Computing Systems" by Nisan and Schocken, 
// MIT Press. Book site: www.idc.ac.il/tecs
// File name: projects/08/FunctionCalls/FibonacciElement/Main.vm

// Computes the n'th element of the Fibonacci series, recursively.
// n is given in argument[0].  Called by the Sys.init function 
// (part of the Sys.vm file), which also pushes the argument[0] 
// parameter before this code starts running.

// function
(Main.fibonacci)
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
// push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
// lt
@SP
A=M-1
D=M
A=A-1
D=M-D
@IF_TRUE_LT0
D;JLT
D=0
@SP
A=M-1
A=A-1
M=D
@IF_FALSE_LT0
0;JMP
(IF_TRUE_LT0)
D=-1
@SP
A=M-1
A=A-1
M=D
(IF_FALSE_LT0)
@SP
M=M-1
// if-goto
@SP
M=M-1
A=M
D=M
@Main.IF_TRUE
D;JNE
// goto
@Main.IF_FALSE
0;JMP
// label
(Main.IF_TRUE)
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
// label
(Main.IF_FALSE)
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
// push constant 2
@2
D=A
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
// call
// push return address
@Main.fibonacci.return_address1
D=A
@SP
A=M
M=D
@SP
M=M+1
//save LCL of the calling funcyion
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
//save ARG of the calling function
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
//save THIS of the calling function
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
//save THAT of the calling function
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
//reposition ARG
@SP
D=M
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@1
D=D-A
@ARG
M=D
//reposition LCL
@SP
D=M
@LCL
M=D
//transfer control
@Main.fibonacci
0;JMP
//Declare a label for the return-address
(Main.fibonacci.return_address1)
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
// push constant 1
@1
D=A
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
// call
// push return address
@Main.fibonacci.return_address2
D=A
@SP
A=M
M=D
@SP
M=M+1
//save LCL of the calling funcyion
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
//save ARG of the calling function
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
//save THIS of the calling function
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
//save THAT of the calling function
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
//reposition ARG
@SP
D=M
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@1
D=D-A
@ARG
M=D
//reposition LCL
@SP
D=M
@LCL
M=D
//transfer control
@Main.fibonacci
0;JMP
//Declare a label for the return-address
(Main.fibonacci.return_address2)
// add
@SP
A=M-1
D=M
A=A-1
M=D+M
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
// This file is part of the materials accompanying the book 
// "The Elements of Computing Systems" by Nisan and Schocken, 
// MIT Press. Book site: www.idc.ac.il/tecs
// File name: projects/08/FunctionCalls/FibonacciElement/Sys.vm

// Pushes n onto the stack and calls the Main.fibonacii function,
// which computes the n'th element of the Fibonacci series.
// The Sys.init function is called "automatically" by the 
// bootstrap code.

// function
(Sys.init)
// push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
// call
// push return address
@Main.fibonacci.return_address3
D=A
@SP
A=M
M=D
@SP
M=M+1
//save LCL of the calling funcyion
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
//save ARG of the calling function
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
//save THIS of the calling function
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
//save THAT of the calling function
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
//reposition ARG
@SP
D=M
D=D-1
D=D-1
D=D-1
D=D-1
D=D-1
@1
D=D-A
@ARG
M=D
//reposition LCL
@SP
D=M
@LCL
M=D
//transfer control
@Main.fibonacci
0;JMP
//Declare a label for the return-address
(Main.fibonacci.return_address3)
// label
(Sys.WHILE)
// goto
@Sys.WHILE
0;JMP
