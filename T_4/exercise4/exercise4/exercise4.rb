
$out ="" #קובץ סופי - XML
$out1="" #קובץ ביניים - T.XML
$word = "" 
$letter=''
$arr =Array.new #מערך עזר משלב 1 לשלב 2
$index=0 #אינדקס למערך עזר 

$Symbol = ["{","}","(",")","[","]",",",";",".","+","-","*","/","&","|","<",">","=","~"]
$keyword = ["class" , "constructor" , "function" , "method" , "field" , "static" , "var" , "int" , "char" , "boolean" ,
		   "void" , "true" , "false" , "null" , "this" , "let" , "do" , "if" , "else" , "while" , "return"]


def Tokenizing(path)
	Dir.chdir(path)
	files = Dir.glob("*.jack")
	for i in files
		file = File.open(i , "a+")
		$out1 = File.new(i.to_s.split(".")[0]+"T.xml", "a+")
		$out = File.new(i.to_s.split(".")[0]+".xml", "a+")
		$out1.puts("<tokens>")
		
	while ($letter = file.getc)
		if($Symbol.include? $word)
			if ($word === "&")
				$word="&amp;"
			elsif ($word === "<")
				$word="&lt;"
			elsif ($word === ">")
				$word="&gt;"
			elsif ($word === '"'.to_s)
			 	$word="&quate;"
			end
			$arr[$index]=("<symbol> "+$word+" </symbol>")
			$index = $index +1
			$out1.puts("<symbol> "+$word+" </symbol>")
			$word=""
		end
		
		case $letter
			when '"'
				if !($word === "")
					ceckWord()
				end
				word2 = ""
				$letter = file.getc
				while !($letter == '"')
					word2 = word2.to_s + $letter.to_s
					$letter = file.getc
				end
				$arr[$index]=("<stringConstant> "+word2+" </stringConstant>")
				$index = $index + 1
				$out1.puts("<stringConstant> "+word2+" </stringConstant>")
				
			when ' ' , "\n","\t" , '{' , '}' , '(' , ')' , '[' , ']' , '.' , ',' , ';' , '+' , '-' , '*' , '&' , '|' , '<' , '>' , '=' , '~'
				if($word==="")
					if (!($letter == ' ') and !($letter.to_s === "\n") and !($letter === "\t"))
						
					$word = $letter.to_s
					if ($word === "&")
						$word="&amp;"
					elsif ($word === "<")
						$word="&lt;"
					elsif ($word === ">")
						$word="&gt;"
					elsif ($word === '"'.to_s)
						$word="&quate;"
					end
					$arr[$index]=("<symbol> "+$word+" </symbol>")
					$index = $index +1
					$out1.puts("<symbol> "+$word+" </symbol>")
					$word=""
					$letter=''
				end
				else
					ceckWord()
				end
				
			  when '/'
				     if !($word === "")
						ceckWord()
					 end
					$letter  = file.getc
					if($letter == '/')
					  file.gets
					elsif($letter == '*')
						x=file.getc.to_s
						y=file.getc.to_s
						word3 = x + y
						while !(word3 === "*/") 
							x=y
							y=file.getc.to_s
					    	word3 = x + y
						end
					else
						$arr[$index]=("<symbol> / </symbol>")
						$index = $index +1
						$out1.puts("<symbol> / </symbol>")
						if (!($letter == ' ') and !($letter.to_s === "\n") and !($letter === "\t"))
							$word=$letter.to_s
						end
					end
					
					 
				
			else
				$word = $word.to_s + $letter.to_s
			end
		end
		$out1.puts("</tokens>")
		parsing() # נבצע פרסינג עבור כל קובץ בניפרד
		$arr = Array.new # איפוס מערך העזר לפני מעבר לקובץ הבא
		$index=0 #איפוס האינדקס    
		
	 end
	end
	
	def ceckWord() # פונקצית עזר לפרסינג לבדיקת סוג המילה
		if($Symbol.include? $word)
				if ($word === "&")
					$word="&amp;"
				elsif ($word === "<")
					$word="&lt;"
				elsif ($word === ">")
					$word="&gt;"
				elsif ($word === '"'.to_s)
					$word="&quate;"
				end
				$arr[$index]=("<symbol> "+$word+" </symbol>")
				$index = $index +1
				$out1.puts("<symbol> "+$word+" </symbol>")
			    $word=$letter
				$letter=''
			
			elsif($keyword.include? $word) 
				$arr[$index]=("<keyword> "+$word+" </keyword>")
				$index = $index +1
				$out1.puts("<keyword> "+$word+" </keyword>")
				if (!($letter == ' ') and !($letter.to_s === "\n"))
					$word=$letter
				else $word = ""
				end
			elsif  (($word === " ")or($word === "\n")or($word === "\t"))
				$word=$letter
			else 
				if (!($word.to_i == 0  ) or ($word === "0"))
					$arr[$index]=("<integerConstant> "+$word+" </integerConstant>")
					$index = $index +1
					$out1.puts("<integerConstant> "+$word+" </integerConstant>")
					if (!($letter == ' ') and !($letter.to_s === "\n")and !($letter.to_s === "\t"))
						$word=$letter
					else $word = ""
					end
				else
					$arr[$index]=("<identifier> "+$word+" </identifier>")
					$index = $index +1
					$out1.puts("<identifier> "+$word+" </identifier>")
   				    if (!($letter == ' ') and !($letter.to_s === "\n")and !($letter.to_s === "\t"))
					    $word=$letter
					else $word = ""
					end
				end
		end
	end
	
	
	def parsing()
		$index=0
		parseClass()
		$index=0
	end
	
	def parseClass()
		$out.puts("<class>")
		$out.puts($arr[$index]) #class
		$index = $index+1
		$out.puts($arr[$index]) #indentifier
		$index = $index+1
		$out.puts($arr[$index]) #{
		$index = $index+1
		parseClassVarDec()
		parseSubroutineDec()
		$out.puts($arr[$index]) #}
		$index = $index+1
		$out.puts("</class>")
	end
	
	def parseClassVarDec()
		while(($arr[$index].include? "static") or ($arr[$index].include? "field"))
			$out.puts("<classVarDec>")
			$out.puts($arr[$index]) #static or field
			$index = $index+1
			$out.puts($arr[$index]) #int or char or boolean or identifier
			$index = $index+1	
			$out.puts($arr[$index]) #indentifier
			$index = $index+1	
			while($arr[$index].include? ",")
				$out.puts($arr[$index]) #,
				$index = $index+1	
				$out.puts($arr[$index]) #indentifier
				$index = $index+1
			end
			$out.puts($arr[$index]) #;
			$index = $index+1	
			$out.puts("</classVarDec>")
		end
	end
	
	def parseSubroutineDec()
		while(($arr[$index].include? "constructor") or ($arr[$index].include? "function") or ($arr[$index].include? "method"))
			$out.puts("<subroutineDec>")
			$out.puts($arr[$index]) #function or const or method
			$index = $index+1	
			$out.puts($arr[$index]) #void or type
			$index = $index+1	
			$out.puts($arr[$index]) #indentifier
			$index = $index+1	
			$out.puts($arr[$index]) #(
			$index = $index+1	
			parseParameterList()
			$out.puts($arr[$index]) #)
			$index = $index+1	
			parseSubroutineBody()
			$out.puts("</subroutineDec>")
		end
	end
	
	def parseParameterList()
		$out.puts("<parameterList>")
		if !($arr[$index].include? ")")
			$out.puts($arr[$index]) #type
			$index = $index+1	
			$out.puts($arr[$index]) #varName
			$index = $index+1	
			while ($arr[$index].include? ",")
				$out.puts($arr[$index]) #,
				$index = $index+1	
				$out.puts($arr[$index]) #type
				$index = $index+1	
				$out.puts($arr[$index]) #varName
				$index = $index+1	
			end
		end
		$out.puts("</parameterList>")
	end
	
	def parseSubroutineBody()
		$out.puts("<subroutineBody>")
		$out.puts($arr[$index]) #{
		$index = $index+1	
		parseVarDec()
		parseStatements()
		$out.puts($arr[$index]) #}
		$index = $index+1	
		$out.puts("</subroutineBody>")
	end
	
	def parseVarDec()
		while ($arr[$index].include? "var")
			$out.puts("<varDec>")
			$out.puts($arr[$index]) #var
			$index = $index+1	
			$out.puts($arr[$index]) #type
			$index = $index+1	
			$out.puts($arr[$index]) #varName
			$index = $index+1	
			while ($arr[$index].include? ",")
				$out.puts($arr[$index]) #,
				$index = $index+1	
				$out.puts($arr[$index]) #varName
				$index = $index+1	
			end
			$out.puts($arr[$index]) #;
			$index = $index+1	
			$out.puts("</varDec>")
		end
	end
	
	def parseStatements()
		$out.puts("<statements>")
		parseStatement()
		$out.puts("</statements>")
	end
	
	def parseStatement()
		while(($arr[$index].include? "let") or ($arr[$index].include? "if") or ($arr[$index].include? "while") or ($arr[$index].include? "do") or ($arr[$index].include? "return"))
			if($arr[$index].include? "let")
				parseLetStatement()
			elsif($arr[$index].include? "if")
				parseIfStatement()
			elsif($arr[$index].include? "while")
				parseWhileStatement()
			elsif($arr[$index].include? "do")
				parsedoStatement()
			else
				parseReturnStatement()
			end
		end
	end
	
	def parseLetStatement()
		$out.puts("<letStatement>")
		$out.puts($arr[$index]) #let
		$index = $index+1	
		$out.puts($arr[$index]) #varName
		$index = $index+1	
		if($arr[$index].include? "[")
			$out.puts($arr[$index]) #[
			$index = $index+1
			parseExpression()
			$out.puts($arr[$index]) #]
			$index = $index+1
		end
		$out.puts($arr[$index]) #=
		$index = $index+1
		parseExpression()
		$out.puts($arr[$index]) #;
		$index = $index+1
		$out.puts("</letStatement>")
	end
	
	def parseIfStatement()
		$out.puts("<ifStatement>")
		$out.puts($arr[$index]) #if
		$index = $index+1	
		$out.puts($arr[$index]) #(
		$index = $index+1	
		parseExpression()
		$out.puts($arr[$index]) #)
		$index = $index+1
		$out.puts($arr[$index]) #{
		$index = $index+1
		parseStatements()
		$out.puts($arr[$index]) #}
		$index = $index+1
		if($arr[$index].include? "else")
			$out.puts($arr[$index]) #else
			$index = $index+1
			$out.puts($arr[$index]) #{
			$index = $index+1
			parseStatements()
			$out.puts($arr[$index]) #}
			$index = $index+1
		end
		$out.puts("</ifStatement>")
	end
	
	def parseWhileStatement()
		$out.puts("<whileStatement>")
		$out.puts($arr[$index]) #while
		$index = $index+1
		$out.puts($arr[$index]) #(
		$index = $index+1
		parseExpression()
		$out.puts($arr[$index]) #)
		$index = $index+1
		$out.puts($arr[$index]) #{
		$index = $index+1
		parseStatements()
		$out.puts($arr[$index]) #}
		$index = $index+1
		$out.puts("</whileStatement>")
	end
	
	def parsedoStatement()
		$out.puts("<doStatement>")
		$out.puts($arr[$index]) #do
		$index = $index+1
		parseSubroutineCall()
		$out.puts($arr[$index]) #;
		$index = $index+1
		$out.puts("</doStatement>")
	end
	
	def parseReturnStatement()
		$out.puts("<returnStatement>")
		$out.puts($arr[$index]) #return
		$index = $index+1
		if !($arr[$index].include? ";")
			parseExpression()
		end
		$out.puts($arr[$index]) #;
		$index = $index+1
		$out.puts("</returnStatement>")
	end
	
	def parseExpression()
		$out.puts("<expression>")
		parseTerm()
		while(($arr[$index].include? "+") or ($arr[$index].include? "-") or ($arr[$index].include? "*") or ($arr[$index][9] === "/") or ($arr[$index].include? "&amp;")or($arr[$index].include? "|") or ($arr[$index].include? "&lt;") or ($arr[$index].include? "&gt;") or ($arr[$index].include? "="))
			$out.puts($arr[$index]) #op
			$index = $index+1
			parseTerm()
		end
		$out.puts("</expression>")
	end
	
	def parseSubroutineCall()
		$out.puts($arr[$index]) #indentifier
		$index = $index+1
		if($arr[$index].include? "(")
			$out.puts($arr[$index]) #(
			$index = $index+1
			parseExpressionList()
			$out.puts($arr[$index]) #)
			$index = $index+1
		else
			$out.puts($arr[$index]) #.
			$index = $index+1
			$out.puts($arr[$index]) #indentifier
			$index = $index+1
			$out.puts($arr[$index]) #(
			$index = $index+1
			parseExpressionList()
			$out.puts($arr[$index]) #)
			$index = $index+1
		end
		
	end
	
	def parseExpressionList()
		$out.puts("<expressionList>")
		if !($arr[$index].include? ")")
			parseExpression()
			while($arr[$index].include? ",")
				$out.puts($arr[$index]) #,
				$index = $index+1
				parseExpression()
			end
		end
		$out.puts("</expressionList>")
	end
	
	def parseTerm()
		$out.puts("<term>")
		if($arr[$index].include? "(")
			$out.puts($arr[$index]) #(
			$index = $index+1
			parseExpression()
			$out.puts($arr[$index]) #)
			$index = $index+1
		elsif($arr[$index+1].include? "[")
			$out.puts($arr[$index]) #varName
			$index = $index+1
			$out.puts($arr[$index]) #[
			$index = $index+1
			parseExpression()
			$out.puts($arr[$index]) #]
			$index = $index+1
		elsif(($arr[$index+1].include? "(") or ($arr[$index+1].include? "."))
			parseSubroutineCall()
		elsif(($arr[$index].include? "-") or ($arr[$index].include? "~"))
			$out.puts($arr[$index]) #unaryOp
			$index = $index+1
			parseTerm()
		else
			$out.puts($arr[$index]) #indentifier
			$index = $index+1
		end
		$out.puts("</term>")
	end
	
Tokenizing("C:/Users/User/Documents/project 10/Square")