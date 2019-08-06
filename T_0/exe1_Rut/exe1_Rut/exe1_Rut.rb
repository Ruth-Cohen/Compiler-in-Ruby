

def s (dirName)
  Dir.chdir dirName
  files = Dir.glob("*.in.txt")
  runNumber = 1
  for i in files
	  if i == "hello.in.txt"
		  begin
			  file = File.open(i,"r") 
			  file2 = File.new("hello.out.txt","w+")
			   while (line = file.gets)
                 file2.puts(line)
				 if line.include? 'you'
					 puts line
				 end
             end
		  end
	  else
		  begin
			file = IO.read(i) 
            open(i, 'w') { |f| f << runNumber << file} 
           	runNumber = runNumber + 1
		  end
	 end
  end 
end

s("dir1")
