@256
D=A
@0
M=D
@300
D=A
@1
M=D
@400
D=A
@2
M=D
@3000
D=A
@3
M=D
@3010
D=A
@4
M=D


@0
D=A
@0
A=M
M=D
@0
M=M+1

@1
D=M
@0
D=D+A
@R13
M=D
@0
M=M-1
A=M
D=M
@R13
A=M
M=D

(LOOP_START)

@2
D=M
@0
A=A+D
D=M
@0
A=M
M=D
@0
M=M+1

@1
D=M
@0
A=A+D
D=M
@0
A=M
M=D
@0
M=M+1

@0
A=M-1
D=M
A=A-1
M=D+M
@0
M=M-1

@1
D=M
@0
D=D+A
@R13
M=D
@0
M=M-1
A=M
D=M
@R13
A=M
M=D

@2
D=M
@0
A=A+D
D=M
@0
A=M
M=D
@0
M=M+1

@1
D=A
@0
A=M
M=D
@0
M=M+1

@0
A=M-1
D=M
A=A-1
M=M-D
@0
M=M-1

@2
D=M
@0
D=D+A
@R13
M=D
@0
M=M-1
A=M
D=M
@R13
A=M
M=D

@2
D=M
@0
A=A+D
D=M
@0
A=M
M=D
@0
M=M+1

@0
A=M
A=A-1
D=M
@0
M=M-1
@LOOP_START
D; JGT
D; JLT

@1
D=M
@0
A=A+D
D=M
@0
A=M
M=D
@0
M=M+1

