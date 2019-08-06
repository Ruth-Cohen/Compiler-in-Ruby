$out ="" #���� ���� - XML
$out1="" #���� ������ - T.XML
$word = ""
$letter=''
$arr =Array.new #���� ��� ���� 1 ���� 2
$index=0 #������ ����� ��� 
$className=""
$classScope=Array.new(4) { Array.new }
$classScopeIndex=0
$staticIndex=0
$fieldIndex=0
$methodScope=Array.new(4) { Array.new }
$argumentIndex=0
$varIndex=0
$methodScopeIndex=0
$functionKind=0
$tempWord=""
$kind=""
$index=0
$type=""
$moneParam = 0
$moneIf=0
$moneWhile=0


$isElse=0
$jump=0

$Symbol = ["{", "}", "(", ")", "[", "]", ",", ";", ".", "+", "-", "*", "/", "&", "|", "<", ">", "=", "~"]
$keyword = ["class", "constructor", "function", "method", "field", "static", "var", "int", "char", "boolean",
            "void", "true", "false", "null", "this", "let", "do", "if", "else", "while", "return"]


def Tokenizing(path)
  Dir.chdir(path)
  files = Dir.glob("*.jack")
  for i in files
    file = File.open(i, "a+")
    $out1 = File.new(i.to_s.split(".")[0]+"T.xml", "a+")
    $out = File.new(i.to_s.split(".")[0]+".vm", "a+")
    $out1.puts("<tokens>")

    while ($letter = file.getc)
      if ($Symbol.include? $word)
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

        when ' ', "\n", "\t", '{', '}', '(', ')', '[', ']', '.', ',', ';', '+', '-', '*', '&', '|', '<', '>', '=', '~'
          if ($word==="")
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
          $letter = file.getc
          if ($letter == '/')
            file.gets
          elsif ($letter == '*')
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
    codeGeneration() # ���� ������ ���� �� ���� ������
    $arr = Array.new # ����� ���� ���� ���� ���� ����� ���
    $index=0 #����� �������

  end
end

def ceckWord() # ������� ��� ������� ������ ��� �����
  if ($Symbol.include? $word)
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

  elsif ($keyword.include? $word)
    $arr[$index]=("<keyword> "+$word+" </keyword>")
    $index = $index +1
    $out1.puts("<keyword> "+$word+" </keyword>")
    if (!($letter == ' ') and !($letter.to_s === "\n"))
      $word=$letter
    else
      $word = ""
    end
  elsif (($word === " ")or($word === "\n")or($word === "\t"))
    $word=$letter
  else
    if (!($word.to_i == 0) or ($word === "0"))
      $arr[$index]=("<integerConstant> "+$word+" </integerConstant>")
      $index = $index +1
      $out1.puts("<integerConstant> "+$word+" </integerConstant>")
      if (!($letter == ' ') and !($letter.to_s === "\n")and !($letter.to_s === "\t"))
        $word=$letter
      else
        $word = ""
      end
    else
      $arr[$index]=("<identifier> "+$word+" </identifier>")
      $index = $index +1
      $out1.puts("<identifier> "+$word+" </identifier>")
      if (!($letter == ' ') and !($letter.to_s === "\n")and !($letter.to_s === "\t"))
        $word=$letter
      else
        $word = ""
      end
    end
  end
end

def findParam(name)
  i=0
  found=0
  $kind=""
  $num=0
  while ((i <= $methodScopeIndex) and (found == 0))
    if ($methodScope[0][i] === name)
      found =1
      $kind=$methodScope[2][i]
      if ($kind === "var")
        $kind="local"
      end
      $num=$methodScope[3][i]
      $type=$methodScope[1][i]
    end

    i=i+1
  end
  i=0
  while ((i <= $classScopeIndex) and (found == 0))
    if ($classScope[0][i] === name)
      found =1
      $type=$classScope[1][i]
      if ($classScope[2][i] === "static")
        $kind="static"
      else
        $kind="this"
        $num=$classScope[3][i]
      end
    end
    i=i+1
  end
  return found
end

def codeGeneration()
  $index=0
  parseClass()
  $index=0
end


def takeWord(temp)
  word=""
  temp = $arr[$index]
  i=0
  while !(temp[i] == ' ')
    i = i + 1
  end
  j=temp.size
  j=j-i-2
  i = i + 1

  while (!(temp[i] == ' ') or (i<j))
    word = word + temp[i].to_s
    i = i + 1
  end

  return word
end

def parseClass()
  $methodScope=Array.new(4) { Array.new }
  $methodScopeIndex=0
  $argumentIndex=0
  $varIndex=0
  $functionKind=0
  $classScope=Array.new(4) { Array.new }
  $classScopeIndex=0
  $staticIndex=0
  $fieldIndex=0
  $index = $index+1 # class
  $className = takeWord($arr[$index]) #nameOfClass
  $index = $index+1
  $index = $index+1 # {

  parseClassVarDec()
  parseSubroutineDec()
  $index = $index+1 # }


end

def parseClassVarDec()
  while (($arr[$index].include? "static") or ($arr[$index].include? "field"))
    $classScope[2][$classScopeIndex]=takeWord($arr[$index])
    if ($arr[$index].include? "static")
      $classScope[3][$classScopeIndex]=$staticIndex #static
      $staticIndex = $staticIndex +1
    else
      $classScope[3][$classScopeIndex]=$fieldIndex #field
      $fieldIndex = $fieldIndex +1
    end
    $index = $index+1
    $classScope[1][$classScopeIndex]=takeWord($arr[$index]) #int or char or boolean or identifier
    $index = $index+1
    $classScope[0][$classScopeIndex]=takeWord($arr[$index]) # identifier
    $index = $index+1
    $classScopeIndex = $classScopeIndex +1
    while ($arr[$index].include? ",")
      $index = $index+1 #,
      $classScope[1][$classScopeIndex]=$classScope[1][$classScopeIndex-1]
      $classScope[2][$classScopeIndex]=$classScope[2][$classScopeIndex-1]
      $classScope[3][$classScopeIndex]=$classScope[3][$classScopeIndex-1]+1
      if ($classScope[2][$classScopeIndex-1] === "static")
        $staticIndex = $staticIndex +1
      else
        $fieldIndex = $fieldIndex +1
      end
      $classScope[0][$classScopeIndex]=takeWord($arr[$index]) # identifier
      $index = $index+1
      $classScopeIndex = $classScopeIndex +1
    end
    $index = $index+1 #;
  end

end

def parseSubroutineDec()
  while (($arr[$index] != nil) and(($arr[$index].include? "constructor") or ($arr[$index].include? "function") or ($arr[$index].include? "method")))
    if ($arr[$index].include? "constructor")
      $moneIf=0
      $moneWhile=0

      $methodScope=Array.new(4) { Array.new }
      $methodScopeIndex=0
      $argumentIndex=0
      $varIndex=0
      $functionKind=0
      $index = $index+1
      $index = $index+1 #type
      temp=takeWord($arr[$index])
      $index = $index+1 #new-indentifier
      $tempWord="function "+ $className +"."+temp+" "
      $index = $index+1 #(
      parseParameterList()

      $index = $index+1 #)
      parseSubroutineBody()
    elsif ($arr[$index].include? "function")
      $moneIf=0
      $moneWhile=0

      $methodScope=Array.new(4) { Array.new }
      $methodScopeIndex=0
      $argumentIndex=0
      $varIndex=0
      $functionKind=1
      $index = $index+1
      $index = $index+1 #type
      temp=takeWord($arr[$index])
      $index = $index+1 #identifier
      $tempWord="function "+ $className +"."+temp+" "
      $index = $index+1 #(
      parseParameterList()
      $index = $index+1 #)
      parseSubroutineBody()
    else #method
      $moneIf=0
      $moneWhile=0

      $functionKind=2
      $index = $index+1 #mthod
      $index = $index+1 #type
      temp=takeWord($arr[$index])
      $index = $index+1 #new-indentifier
      $tempWord="function "+ $className +"."+temp+" "

      $index = $index+1 #(
      $methodScope=Array.new(4) { Array.new }
      $methodScopeIndex=0
      $argumentIndex=0
      $varIndex=0
      parseParameterList()
      $index = $index+1 #)
      parseSubroutineBody()
    end
  end


end

def parseParameterList()
  if ($functionKind == 2)
    $methodScope[0][$methodScopeIndex]="this"
    $methodScope[1][$methodScopeIndex]=$className
    $methodScope[2][$methodScopeIndex]="argument"
    $methodScope[3][$methodScopeIndex]=$argumentIndex
    $argumentIndex = $argumentIndex +1
    $methodScopeIndex = $methodScopeIndex +1
  end

  if !($arr[$index].include? ")")
    $methodScope[1][$methodScopeIndex]=takeWord($arr[$index])
    $index = $index+1
    $methodScope[0][$methodScopeIndex]=takeWord($arr[$index])
    $index = $index+1
    $methodScope[2][$methodScopeIndex]="argument"
    $methodScope[3][$methodScopeIndex]=$argumentIndex
    $argumentIndex = $argumentIndex +1
    $methodScopeIndex = $methodScopeIndex +1
    while ($arr[$index].include? ",")
      $index = $index+1 #,
      $methodScope[1][$methodScopeIndex]=takeWord($arr[$index])
      $index = $index+1
      $methodScope[0][$methodScopeIndex]=takeWord($arr[$index])
      $index = $index+1
      $methodScope[2][$methodScopeIndex]="argument"
      $methodScope[3][$methodScopeIndex]=$argumentIndex
      $argumentIndex = $argumentIndex +1
      $methodScopeIndex = $methodScopeIndex +1
    end
  end

end

def parseSubroutineBody()
  $index = $index+1 #{
  parseVarDec()
  $out.puts($tempWord.to_s+$varIndex.to_s+"\n")
  if ($functionKind == 0)
    $out.puts("push constant "+$fieldIndex.to_s+"\n") # �� ����� �� ������
    $out.puts("call Memory.alloc 1\n") # �� ������ �� ������� ��� ���� ���� ����� ����� ������
    $out.puts("pop pointer 0") # ���� �� ����� ������ �� ������� ���
  elsif ($functionKind == 2)
    $out.puts("push argument 0") # �� �� ����� ���� ������ �� �������� ������ ����
    $out.puts("pop pointer 0") # THIS ���� ������ 0 ����� �� THIS
  end
  parseStatements()
  $index = $index+1 #}


end

def parseVarDec()
  while ($arr[$index].include? "var")
    $methodScope[2][$methodScopeIndex]=takeWord($arr[$index])
    $index = $index+1
    $methodScope[1][$methodScopeIndex]=takeWord($arr[$index])
    $index = $index+1
    $methodScope[0][$methodScopeIndex]=takeWord($arr[$index])
    $index = $index+1
    $methodScope[3][$methodScopeIndex]=$varIndex
    $varIndex = $varIndex +1
    $methodScopeIndex = $methodScopeIndex +1
    while ($arr[$index].include? ",")
      $index = $index+1 #,
      $methodScope[2][$methodScopeIndex]=$methodScope[2][$methodScopeIndex-1]
      $methodScope[1][$methodScopeIndex]=$methodScope[1][$methodScopeIndex-1]
      $methodScope[0][$methodScopeIndex]=takeWord($arr[$index])
      $index = $index+1
      $methodScope[3][$methodScopeIndex]=$varIndex
      $varIndex = $varIndex +1
      $methodScopeIndex = $methodScopeIndex +1
    end
    $index = $index+1 #;
  end


end

def parseStatements()
  parseStatement()

#		$out.puts("<statements>")
#		parseStatement()
#		$out.puts("</statements>")
end

def parseStatement()
  while (($arr[$index].include? "let") or ($arr[$index].include? "if") or ($arr[$index].include? "while") or ($arr[$index].include? "do") or ($arr[$index].include? "return"))
    if ($arr[$index].include? "let")
      parseLetStatement()
    elsif ($arr[$index].include? "while")
      parseWhileStatement()
    elsif ($arr[$index].include? "do")
      parsedoStatement()
    elsif ($arr[$index].include? "return")
      parseReturnStatement()
    else
      parseIfStatement()
    end
  end
end

def parseLetStatement()
  $index = $index+1 #let
  temp=takeWord($arr[$index]) #varName
  $index = $index+1
  enterLoop=0 #���� ������ add ��� ���� ��� �����
  if ($arr[$index].include? "[")
    enterLoop=1
    $index = $index+1 #[    #????? ��� ������� ������ ���� ����
    parseExpression()
    $index = $index+1 #]
  end
  $index = $index+1 #=

  if (enterLoop==1)
    findParam(temp)
    $out.puts("push "+$kind.to_s+" "+$num.to_s+"\n") #��� ����� ����� ������ ������
    $out.puts("add\n")
    parseExpression()
    $out.puts("pop temp 0\n")
    $out.puts("pop pointer 1\n")
    $out.puts("push temp 0\n")
    $out.puts("pop that 0\n")
  else
    parseExpression()
    findParam(temp)
    $out.puts("pop "+$kind.to_s+" "+$num.to_s+"\n") # ���� �����
  end

  $index = $index+1 #;


end

def parseIfStatement()
  i =$moneIf.to_s
  $moneIf = $moneIf +1
  $index = $index+1 #if
  $index = $index+1 #(
  parseExpression()
  $out.puts("if-goto IF_TRUE_LABEL_"+i+"\n")
  $out.puts("goto IF_FALSE_LABEL_"+i+"\n")
  $index = $index+1 #)
  $index = $index+1 #{
  $out.puts("label IF_TRUE_LABEL_"+i+"\n")
  parseStatements()
  $out.puts("goto IF_END_LABEL_"+i+"\n")
  $out.puts("label IF_FALSE_LABEL_"+i+"\n")
  $index = $index+1 #}
  if ($arr[$index].include? "else")

    $index = $index+1 #else
    $index = $index+1 #{
    parseStatements()
    $index = $index+1 #}
    #$moneIf=$moneIf-1
  end
  $out.puts("label IF_END_LABEL_"+i+"\n")

end

def parseWhileStatement()
  i = $moneWhile.to_s
  $moneWhile= $moneWhile+1

  $index = $index+1 #while
  $out.puts("label WHILE_START_LABEL_"+i+"\n")
  $index = $index+1 #(
  parseExpression()
  $out.puts("not")
  $out.puts("if-goto WHILE_END_LABEL_"+i+"\n")
  $index = $index+1 #)
  $index = $index+1 #{
  parseStatements()
  $index = $index+1 #}
  $out.puts("goto WHILE_START_LABEL_"+i+"\n")
  $out.puts("label WHILE_END_LABEL_"+i+"\n")

#		$out.puts("<whileStatement>")
#		$out.puts($arr[$index]) #while
#		$index = $index+1
#		$out.puts($arr[$index]) #(
#		$index = $index+1
#		parseExpression()
#		$out.puts($arr[$index]) #)
#		$index = $index+1
#		$out.puts($arr[$index]) #{
#		$index = $index+1
#		parseStatements()
#		$out.puts($arr[$index]) #}
#		$index = $index+1
#		$out.puts("</whileStatement>")
end

def parsedoStatement()
  $index = $index+1 #do
  parseSubroutineCall()
  $out.puts("pop temp 0")
  $index = $index+1 #;

end

def parseReturnStatement()
  $index = $index+1 #return
  if !($arr[$index].include? ";")
    parseExpression()
    $out.puts("return\n")
  else
    $out.puts("push constant 0\n")
    $out.puts("return\n")
  end
  $index = $index+1 #;

end

def parseExpression()
  parseTerm()
  while (($arr[$index].include? "+") or ($arr[$index].include? "-") or ($arr[$index].include? "*") or ($arr[$index][9] === "/") or ($arr[$index].include? "&amp;")or($arr[$index].include? "|") or ($arr[$index].include? "&lt;") or ($arr[$index].include? "&gt;") or ($arr[$index].include? "="))
    if ($arr[$index].include? "+")
      op =takeWord($arr[$index])
      $index = $index+1
      parseTerm()
      $out.puts("add\n")
    elsif ($arr[$index].include? "-")
      $index = $index+1
      parseTerm()
      $out.puts("sub\n")
    elsif ($arr[$index].include? "*")
      $index = $index+1
      parseTerm()
      $out.puts("call Math.multiply 2\n")
    elsif ($arr[$index][9] === "/")
      $index = $index+1
      parseTerm()
      $out.puts("call Math.divide 2\n")
    elsif ($arr[$index].include? "&amp;")
      $index = $index+1
      parseTerm()
      $out.puts("and\n")
    elsif ($arr[$index].include? "|")
      $index = $index+1
      parseTerm()
      $out.puts("or\n")
    elsif ($arr[$index].include? "&lt;")
      $index = $index+1
      parseTerm()
      $out.puts("lt\n")
    elsif ($arr[$index].include? "&gt;")
      $index = $index+1
      parseTerm()
      $out.puts("gt\n")
    elsif ($arr[$index].include? "=")
      $index = $index+1
      parseTerm()
      $out.puts("eq\n")
    end
  end


end

def parseSubroutineCall()
  v = findParam(takeWord($arr[$index]))
  if (v != 0)
    $out.puts("push "+$kind.to_s+" "+$num.to_s+"\n")

    $index = $index+1 #var
    $index = $index+1 #.
    t=takeWord($arr[$index])
    $index = $index+1
    $index = $index+1 #(
    type1=$type
    parseExpressionList()
    numsParam = $moneParam +1

    $index = $index+1 #)
    $out.puts("call "+type1.to_s+"."+t.to_s+" "+numsParam.to_s)
  else
    functionCall1=takeWord($arr[$index])
    functionCall=""
    numsParam=0
    $index = $index+1
    if ($arr[$index].include? "(")
      $out.puts("push pointer 0\n")
      functionCall=$className.to_s+"."+functionCall1
      $index = $index+1 #(
      $moneParam = 0
      parseExpressionList()
      numsParam= $moneParam+1
      $index = $index+1 #)
    else
      $index = $index+1 #.
      functionCall2=takeWord($arr[$index])
      $index = $index+1
      $index = $index+1 #(
      parseExpressionList()
      numsParam=$moneParam
      $index = $index+1 #)
      functionCall=functionCall1+"."+functionCall2
    end
    $out.puts("call "+functionCall.to_s+" "+numsParam.to_s+"\n") #������ �������� �� �� ���������� ���
  end

end

def parseExpressionList()
  $moneParam=0
  if !($arr[$index].include? ")")
    $moneParam = $moneParam+1
    parseExpression()
    while ($arr[$index].include? ",")
      $index = $index+1 #,
      $moneParam = $moneParam+1
      parseExpression()
    end
  end


end

def parseTerm()
  if (($arr[$index]).include? "stringConstant")
    t=takeWord($arr[$index]) #indentifier
    orec = t.to_s.size
    $out.puts("push constant "+orec.to_s+"\n")
    $out.puts("call String.new 1\n")
    $index = $index+1
    t.each_byte do |c|
      $out.puts("push constant "+c.to_s+"\n")
      $out.puts("call String.appendChar 2\n")
    end
  elsif (($arr[$index]).include? "integerConstant")
    t = takeWord($arr[$index]) #indentifier
    $index = $index+1
    $out.puts("push constant "+t+"\n")
  elsif ($arr[$index].include? "(")
    $index = $index+1 #(
    parseExpression()
    $index = $index+1 #)
  elsif ($arr[$index+1].include? "[")
    n =takeWord($arr[$index]) #varName
    $index = $index+1
    $index = $index+1 #[
    parseExpression()
    $index = $index+1 #]
    findParam(n)
    $out.puts("push "+$kind.to_s+" "+$num.to_s+"\n")
    $out.puts("add\n")
    $out.puts("pop pointer 1\n")
    $out.puts("push that 0\n")
  elsif (($arr[$index].include? "-") or ($arr[$index].include? "~"))
    op= takeWord($arr[$index]) #unaryOp
    $index = $index+1
    parseTerm()
    if (op==="-")
      $out.puts("neg\n")
    else
      $out.puts("not\n")
    end
  elsif (($arr[$index+1].include? "(") or ($arr[$index+1].include? "."))
    parseSubroutineCall()
  elsif (($arr[$index].include? "true") or ($arr[$index].include? "false")or($arr[$index].include? "null") or ($arr[$index].include? "this"))
    if (($arr[$index].include? "null") or ($arr[$index].include? "false"))
      $index = $index+1 #null or false
      $out.puts("push constant 0\n")
    elsif ($arr[$index].include? "true")
      $index = $index+1 #true
      $out.puts("push constant 0\n")
      $out.puts("not\n")
    elsif $index = $index+1 #this
      $out.puts("push pointer 0\n")
    end
  else
    t = takeWord($arr[$index]) #indentifier
    $index = $index+1
    findParam(t)
    $out.puts("push "+$kind.to_s+" "+$num.to_s+"\n")

  end

end

#Tokenizing("C:/aaa/t5 hagasha/t5 hagasha/Seven")
#Tokenizing("C:/aaa/t5 hagasha/t5 hagasha/ConvertToBin")
Tokenizing("C:/aaa/t5 hagasha/t5 hagasha/Square")
#Tokenizing("C:/aaa/t5 hagasha/t5 hagasha/Pong")
#Tokenizing("C:/aaa/t5 hagasha/t5 hagasha/ComplexArrays")
#Tokenizing("C:/aaa/t5 hagasha/t5 hagasha/Average")

