
//push constant 10

@10
D=A
@0
M=M+1
A=M-1
M=D

//pop local 0

@LCL
D=M
@0
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

//push constant 21

@21
D=A
@0
M=M+1
A=M-1
M=D

//push constant 22

@22
D=A
@0
M=M+1
A=M-1
M=D

//pop argument 2

@ARG
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

//pop that 2

@THAT
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

//pop argument 1

@ARG
D=M
@1
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

//push constant 36

@36
D=A
@0
M=M+1
A=M-1
M=D

//pop this 6

@THIS
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

//push constant 42

@42
D=A
@0
M=M+1
A=M-1
M=D

//push constant 45

@45
D=A
@0
M=M+1
A=M-1
M=D

//pop that 5

@THAT
D=M
@5
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

//push constant 510

@510
D=A
@0
M=M+1
A=M-1
M=D

//pop temp 6

@5
D=A
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

//push local 0

@0
D=A
@LCL
A=M
A=D+A
D=M
@0
M=M+1
A=M-1
M=D
//push that 5

@5
D=A
@THAT
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

//push argument 1

@1
D=A
@ARG
A=M
A=D+A
D=M
@0
M=M+1
A=M-1
M=D
//sub

@0
M=M-1
A=M
D=M
A=A-1
M=M-D

//push this 6

@6
D=A
@THIS
A=M
A=D+A
D=M
@0
M=M+1
A=M-1
M=D
//push this 6

@6
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

//sub

@0
M=M-1
A=M
D=M
A=A-1
M=M-D

//push temp 6

@6
D=A
@5
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
