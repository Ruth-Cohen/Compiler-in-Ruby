# Targil02-CHAVA ADLER 315582403 - RUT SPANIER 316213164
require 'find'

def init(f)
  f.puts("@256\nD=A\n@0\nM=D\n@300\nD=A\n@1\nM=D\n@400\nD=A\n@2\nM=D\n@3000\nD=A\n@3\nM=D\n@3010\nD=A\n@4\nM=D\n\n")
end

myfile = []

#Just an example of where it is found by me:
Find.find('C:\project 08') do |path|
  myfile << path if path =~ /.*\.vm$/
end

#Merges all the files into one
f = File.new("c:\\joined.txt", "a+")
myfile.each do |f_name|
  f_in = File.open(f_name, "r")
  f_in.each { |f_str| f.puts(f_str)}
  f_in.close
end
f.close

# Just a Unit Test to see all the lines printed out
line_num=0
File.open(f).each do |line|
  print "#{line_num += 1} #{line}"
end

=begin
Dir.chdir(out_file)
callFunc_case("call Sys.init 0,out_file, counter)
files = Dir.glob("*.vm")
	for i in files
		vm = File.open(i , "a+")
		while(arr = vm.gets)
			arr = line.split
			arr[0] = line.first
			arr[1]=line[1]
			arr[2]=line[2]
=end


def push_case(arr, f,fname)
  x = arr[2]
  case arr[1]
    when 'constant'
      f.puts("@"+x+"\nD=A\n@0\nA=M\nM=D\n@0\nM=M+1\n\n")
    when 'local'
      f.puts("@1\nD=M\n@"+x+"\nA=A+D\nD=M\n@0\nA=M\nM=D\n@0\nM=M+1\n\n")
    when 'argument'
      f.puts("@2\nD=M\n@"+x+"\nA=A+D\nD=M\n@0\nA=M\nM=D\n@0\nM=M+1\n\n")
    when 'this'
      f.puts("@3\nD=M\n@"+x+"\nA=A+D\nD=M\n@0\nA=M\nM=D\n@0\nM=M+1\n\n")
    when 'that'
      f.puts("@4\nD=M\n@"+x+"\nA=A+D\nD=M\n@0\nA=M\nM=D\n@0\nM=M+1\n\n")
    when 'temp'
      y = x.to_i + 5
      f.puts("@"+y.to_s+"\nD=M\n@0\nA=M\nM=D\n@0\nM=M+1\n\n")
    when 'pointer'
      y = x.to_i + 3
      f.puts("@"+y.to_s+"\nD=M\n@0\nA=M\nM=D\n@0\nM=M+1\n\n")
    when 'static'
      f.puts("@"+fname+"."+x.to_s+"\nD=M\n@0\nA=M\nM=D\n@0\nM=M+1\n\n")
    else
      raise 'Impossible'
  end
end

def pop_case(arr,f,fname)
  x = arr[2]
  case arr[1]
    when 'local'
      f.puts("@1\nD=M\n@"+x+"\nD=D+A\n@R13\nM=D\n@0\nM=M-1\nA=M\nD=M\n@R13\nA=M\nM=D\n\n")
    when 'argument'
      f.puts("@2\nD=M\n@"+x+"\nD=D+A\n@R13\nM=D\n@0\nM=M-1\nA=M\nD=M\n@R13\nA=M\nM=D\n\n")
    when 'this'
      f.puts("@3\nD=M\n@"+x+"\nD=D+A\n@R13\nM=D\n@0\nM=M-1\nA=M\nD=M\n@R13\nA=M\nM=D\n\n")
    when 'that'
      f.puts("@4\nD=M\n@"+x+"\nD=D+A\n@R13\nM=D\n@0\nM=M-1\nA=M\nD=M\n@R13\nA=M\nM=D\n\n")
    when 'temp'
      y = x.to_i + 5
      f.puts("@0\nM=M-1\nA=M\nD=M\n@"+y.to_s+"\nM=D\n\n")
    when 'pointer'
      y = x.to_i + 3
      f.puts("@0\nM=M-1\nA=M\nD=M\n@"+y.to_s+"\nM=D\n\n")
    when 'static'
      f.puts("@0\nM=M-1\nA=M\nD=M\n@"+fname+"."+x.to_s+"\nM=D\n\n")
    else
      raise 'Impossible'
  end
end

def add_case(f)
  f.puts("@0\nA=M-1\nD=M\nA=A-1\nM=D+M\n@0\nM=M-1\n\n")
end

def sub_case(f)
  f.puts("@0\nA=M-1\nD=M\nA=A-1\nM=M-D\n@0\nM=M-1\n\n")
end

def eq_case(f,x)
  f.puts("@0\nA=M-1\nD=M\nA=A-1\nD=M-D\n@0\nM=M-1\nM=M-1\n@NEQ"+x.to_s+"\nD; JNE\nD=D-1\n@0\nA=M\nM=D\n@END"+x.to_s+"\n0; JMP\n(NEQ"+x.to_s+")\n@0\nD=A\nA=M\nM=D\n(END"+x.to_s+")\n@0\nM=M+1\n\n")
end

def gt_case(f,x)
  f.puts("@0\nA=M-1\nD=M\nA=A-1\nD=M-D\n@0\nM=M-1\nM=M-1\n@LBL"+x.to_s+"\nD; JLE\n@0\nD=A\nD=D-1\nA=M\nM=D\n@END"+x.to_s+"\n0; JMP\n(LBL"+x.to_s+")\n@0\nD=A\nA=M\nM=D\n(END"+x.to_s+")\n@0\nM=M+1\n\n")
end

def lt_case(f,x)
  f.puts("@0\nA=M-1\nD=M\nA=A-1\nD=M-D\n@0\nM=M-1\nM=M-1\n@LBL"+x.to_s+"\nD; JGE\n@0\nD=A\nD=D-1\nA=M\nM=D\n@END"+x.to_s+"\n0; JMP\n(LBL"+x.to_s+")\n@0\nD=A\nA=M\nM=D\n(END"+x.to_s+")\n@0\nM=M+1\n\n")
end

def neg_case(f)
  f.puts("@0\nA=M-1\nM=-M\n\n")
end

def and_case(f)
    f.puts("@0\nA=M-1\nD=M\nA=A-1\nM=D&M\n@0\nM=M-1\n\n")
end

def or_case(f)
    f.puts("@0\nA=M-1\nD=M\nA=A-1\nM=D|M\n@0\nM=M-1\n\n")
end

def label_case(f, arr) #f - name of the code, lname - name of the loop
    lname = arr[1]
    f.puts("("+lname.to_s+")\n\n")
end

def goto_case(f, arr)
    lname = arr[1]
    f.puts("@"+lname.to_s+"\n0; JMP\n\n")
end

def if_goto_case(f, arr)
  lname = arr[1]
  f.puts("@0\nA=M\nA=A-1\nD=M\n@0\nM=M-1\n@"+lname.to_s+"\nD; JGT\nD; JLT\n\n")
end

def callFunc_case(arr, f, x)
  funcName1 = arr[1]
  numArg = arr[2]
  n = numArg.to_i - 5
  f.puts("@"+funcName1+ ".ReturnAddress"+x.to_s+"\nD=A\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@LCL\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@ARG\nD=M\n@SP\nA=M
	 \nM=D\n@SP\nM=M+1\n@THIS\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@THAT\nD=M\n@SP\nA=M\nM=D\n@SP\nM=M+1\n@SP\nD=M\n@"+n.to_s+"\nD=D-A\n@ARG\nM=D
   \n@SP\nD=M\n@LCL\nM=D\n@"+funcName1+"\n0; JMP\n("+funcName1+".ReturnAddress"+x.to_s+"\n\n")
	 x = x + 1
end

def function_case(arr, f)
  funcName1 = arr[1]
  numArg = arr[2]
  f.puts("("+funcName1+")\n@"+numArg+"\nD=A\n@"+funcName1+".End\nD; JEQ\n("+funcName1+".Loop)\n@SP\nA=M\nM=0\n@SP\nM=M+1\n@"+funcName1+".Loop
     \nD=D-1; JNE\n("+funcName1+".End)\n\n")
end

def return_case(f)
  f.puts("\n@LCL\nD=M\n@5\nA=D-A\nD=M\n@13\nM=D\n@SP\nM=M-1\nA=M\nD=M\n@ARG\nA=M\nM=D\n@ARG\nD=M\n@SP\nM=D+1\n@LCL\nM=M-1\nA=M\nD=M\n@THAT
    \nM=D\n@LCL\nM=M-1\nA=M\nD=M\n@THIS\nM=D\n@LCL\nM=M-1\nA=M\nD=M\n@ARG\nM=D\n@LCL\nM=M-1\nA=M\nD=M\n@LCL\nM=D\n@13\nA=M\n0; JMP")
end

#Start of the Main
#puts("Please insert the name of the file\n")
#file = gets

#file = 'BasicTest'
#file = 'PointerTest'
#file = 'SimpleAdd'
#file = 'StackTest'
#file = 'StaticTest'


#file = 'BasicLoop'
#file = 'FibonacciElement'
#file = 'FibonacciSeries'
file = 'SimpleFunction'
#file = 'StaticsTest'




myfile = ""
#Find.find('C:\project 07\MemoryAccess\BasicTest') do |path|
#Find.find('C:\project 07\MemoryAccess\SimpleAdd') do |path|
#Find.find('C:\project 07\MemoryAccess\StackTest') do |path|
#Find.find('C:\project 07\MemoryAccess\StaticTest') do |path|

#Find.find('C:\project 08\FunctionCalls\BasicLoop') do |path|
#Find.find('C:\project 08\FunctionCalls\FibonacciElement') do |path|
#Find.find('C:\project 08\FunctionCalls\FibonacciSeries') do |path|
Find.find('C:\project 08\FunctionCalls\SimpleFunction') do |path|
#Find.find('C:\project 08\FunctionCalls\StaticsTest') do |path|
  myfile << path if path =~ /.*\.vm$/
end

counter=0
counter1=1

arr = []
out_file = File.new("#{file}.asm", "w+")
File.open(myfile, "r") do |f|
  init(out_file)
  f.each_line do |line|
    arr = line.split(' ') #arr is an array that gets the current lined parsed
    counter += 1
    case arr[0]
      when 'push'
          push_case(arr,out_file,file)
      when 'pop'
          pop_case(arr,out_file,file)
      when 'add'
          add_case(out_file)
      when 'sub'
          sub_case(out_file)
      when 'eq'
          eq_case(out_file,counter)
      when 'lt'
          lt_case(out_file,counter)
      when 'gt'
          gt_case(out_file,counter)
      when '//'
      when 'neg'
           neg_case(out_file)
      when 'and'
           and_case(out_file)
      when 'or'
           or_case(out_file)
      when 'label'
           label_case(out_file, arr)
      when 'if-goto'
            if_goto_case(out_file, arr)
      when 'goto'
            goto_case(out_file, arr)
      when 'call'
            callFunc_case(arr, out_file, counter1)
      when 'function'
            function_case(arr, out_file)
      when 'return'
            return_case( out_file)
      else
            out_file.puts("\n")
    end #of case arr[0]

  end #f.each_line
end #whole loop


