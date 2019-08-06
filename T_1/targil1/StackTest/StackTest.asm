
//push constant 17

@17
D=A
@0
M=M+1
A=M-1
M=D

//push constant 17

@17
D=A
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

//eq

@0
M=M-1
A=M
D=M
A=A-1
A=M
D=A-D
@TRUE1
D;JEQ
@0
A=M-1
M=0
@FALSE1
0;JEQ
(TRUE1)
@0
A=M-1
M=-1
(FALSE1)

//push constant 892

@892
D=A
@0
M=M+1
A=M-1
M=D

//push constant 53

@53
D=A
@0
M=M+1
A=M-1
M=D

//push constant 891

@891
D=A
@0
M=M+1
A=M-1
M=D

//lt

@0
M=M-1
A=M
D=M
A=A-1
A=M
D=A-D
@TRUE2
D;JLT
@0
A=M-1
M=0
@FALSE2
0;JEQ
(TRUE2)
@0
A=M-1
M=-1
(FALSE2)

//push constant 31

@31
D=A
@0
M=M+1
A=M-1
M=D

//push constant 32767

@32767
D=A
@0
M=M+1
A=M-1
M=D

//push constant 32766

@32766
D=A
@0
M=M+1
A=M-1
M=D

//gt

@0
M=M-1
A=M
D=M
A=A-1
A=M
D=A-D
@TRUE3
D;JGT
@0
A=M-1
M=0
@FALSE3
0;JEQ
(TRUE3)
@0
A=M-1
M=-1
(FALSE3)

//push constant 56

@56
D=A
@0
M=M+1
A=M-1
M=D

//push constant 112

@112
D=A
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

//neg

@0
A=M
A=A-1
M=-M

//and

@0
A=M
A=A-1
D=M
A=A-1
M=M&D
@0
M=M-1

//push constant 82

@82
D=A
@0
M=M+1
A=M-1
M=D

//or

@0
A=M
A=A-1
D=M
A=A-1
M=M|D
@0
M=M-1

//push constant 17

@17
D=A
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

//push constant 17

@17
D=A
@0
M=M+1
A=M-1
M=D

//eq

@0
M=M-1
A=M
D=M
A=A-1
A=M
D=A-D
@TRUE1
D;JEQ
@0
A=M-1
M=0
@FALSE1
0;JEQ
(TRUE1)
@0
A=M-1
M=-1
(FALSE1)

//push constant 53

@53
D=A
@0
M=M+1
A=M-1
M=D

//push constant 892

@892
D=A
@0
M=M+1
A=M-1
M=D

//push constant 891

@891
D=A
@0
M=M+1
A=M-1
M=D

//lt

@0
M=M-1
A=M
D=M
A=A-1
A=M
D=A-D
@TRUE2
D;JLT
@0
A=M-1
M=0
@FALSE2
0;JEQ
(TRUE2)
@0
A=M-1
M=-1
(FALSE2)

//push constant 31

@31
D=A
@0
M=M+1
A=M-1
M=D

//push constant 32767

@32767
D=A
@0
M=M+1
A=M-1
M=D

//push constant 32766

@32766
D=A
@0
M=M+1
A=M-1
M=D

//gt

@0
M=M-1
A=M
D=M
A=A-1
A=M
D=A-D
@TRUE3
D;JGT
@0
A=M-1
M=0
@FALSE3
0;JEQ
(TRUE3)
@0
A=M-1
M=-1
(FALSE3)

//push constant 56

@56
D=A
@0
M=M+1
A=M-1
M=D

//push constant 112

@112
D=A
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

//neg

@0
A=M
A=A-1
M=-M

//and

@0
A=M
A=A-1
D=M
A=A-1
M=M&D
@0
M=M-1

//push constant 82

@82
D=A
@0
M=M+1
A=M-1
M=D

//or

@0
A=M
A=A-1
D=M
A=A-1
M=M|D
@0
M=M-1
