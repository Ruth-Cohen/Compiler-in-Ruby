
//push constant 3030

@3030
D=A
@0
M=M+1
A=M-1
M=D

//pop pointer 0

@0
M=M-1
A=M
D=M
@THIS
M=D

//push constant 3040

@3040
D=A
@0
M=M+1
A=M-1
M=D

//pop pointer 1

@0
M=M-1
A=M
D=M
@THAT
M=D

//push that 6

@6
D=A
@THAT
A=M
A=D+A
D=M
@0
M=M+1
A=M-1
M=D
//push constant 32

@32
D=A
@0
M=M+1
A=M-1
M=D

//pop this 2

@THIS
D=M
@2
D=D+A
@13
M=D
@SP
M=M-1
A=M
D=M
@13
A=M
M=D

//sub

@0
M=M-1
A=M
D=M
A=A-1
M=M-D

//push constant 46

@46
D=A
@0
M=M+1
A=M-1
M=D

//pop that 6

@THAT
D=M
@6
D=D+A
@13
M=D
@SP
M=M-1
A=M
D=M
@13
A=M
M=D

//push pointer 0

@THIS
D=M
@0
M=M+1
A=M-1
M=D

//push pointer 1

@THAT
D=M
@0
M=M+1
A=M-1
M=D

//add

@0
M=M-1
A=M
D=M
A=A-1
M=M+D

//push this 2

@2
D=A
@THIS
A=M
A=D+A
D=M
@0
M=M+1
A=M-1
M=D
//add

@0
M=M-1
A=M
D=M
A=A-1
M=M+D
