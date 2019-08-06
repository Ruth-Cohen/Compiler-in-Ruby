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
// File name: projects/08/FunctionCalls/StaticsTest/Class1.vm

// Stores two supplied arguments in static[0] and static[1].
// function
(Class1.set)
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
// pop static 0
@SP
M=M-1
A=M
D=M
@Class1.0
M=D
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
// pop static 1
@SP
M=M-1
A=M
D=M
@Class1.1
M=D
// push constant 0
@0
D=A
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

// Returns static[0] - static[1].
// function
(Class1.get)
// push static 0
@Class1.0
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1
@Class1.1
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
// This file is part of the materials accompanying the book 
// "The Elements of Computing Systems" by Nisan and Schocken, 
// MIT Press. Book site: www.idc.ac.il/tecs
// File name: projects/08/FunctionCalls/StaticsTest/Class2.vm

// Stores two supplied arguments in static[0] and static[1].
// function
(Class2.set)
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
// pop static 0
@SP
M=M-1
A=M
D=M
@Class2.0
M=D
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
// pop static 1
@SP
M=M-1
A=M
D=M
@Class2.1
M=D
// push constant 0
@0
D=A
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

// Returns static[0] - static[1].
// function
(Class2.get)
// push static 0
@Class2.0
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1
@Class2.1
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
// This file is part of the materials accompanying the book 
// "The Elements of Computing Systems" by Nisan and Schocken, 
// MIT Press. Book site: www.idc.ac.il/tecs
// File name: projects/08/FunctionCalls/StaticsTest/Sys.vm

// Tests that different functions, stored in two different 
// class files, manipulate the static segment correctly. 
// function
(Sys.init)
// push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1
// call
// push return address
@Class1.set.return_address1
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
@2
D=D-A
@ARG
M=D
//reposition LCL
@SP
D=M
@LCL
M=D
//transfer control
@Class1.set
0;JMP
//Declare a label for the return-address
(Class1.set.return_address1)
// pop temp 0 // Dumps the return value
@SP
A=M-1
D=M
@5
M=D
@SP
M=M-1
// push constant 23
@23
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 15
@15
D=A
@SP
A=M
M=D
@SP
M=M+1
// call
// push return address
@Class2.set.return_address2
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
@2
D=D-A
@ARG
M=D
//reposition LCL
@SP
D=M
@LCL
M=D
//transfer control
@Class2.set
0;JMP
//Declare a label for the return-address
(Class2.set.return_address2)
// pop temp 0 // Dumps the return value
@SP
A=M-1
D=M
@5
M=D
@SP
M=M-1
// call
// push return address
@Class1.get.return_address3
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
@Class1.get
0;JMP
//Declare a label for the return-address
(Class1.get.return_address3)
// call
// push return address
@Class2.get.return_address4
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
@Class2.get
0;JMP
//Declare a label for the return-address
(Class2.get.return_address4)
// label
(Sys.WHILE)
// goto
@Sys.WHILE
0;JMP
