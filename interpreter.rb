require_relative 'model.rb'

# Token

class Token
    attr_accessor :type, :line, :column, :contents

    def initialize(type, contents, line, column)
        @type = type
        @contents = contents
        @line = line
        @column = column
        
    end

    # Example: (IntegerLiteral, "5", 0, 0)
    def to_s
        "(#{@type}, \"#{@contents}\", #{@line}, #{@column})"
    end

end


# Lexer
class Lexer
    attr_accessor :tokens, :line, :column, :validity, :expression, :error

    def initialize(expression, env)
        @tokens = []
        @line = 0
        @column = 0
        @expression = expression
        @validity = true
        @error = ""
        @env = env
    end

    def lex(input)
        
        while @line < @expression.length
            # Whitespace
            if input[@line] == " "
                @line += 1
                @column += 1
            # Left Parenthesis - Expression start
            elsif input[@line] == "("          
                @tokens.push(Token.new(Expression, "(", @line, @column))
                @line += 1
                @column += 1
            # Right Parenthesis - Expression end
            elsif input[@line] == ")" 
                @tokens.push(Token.new(Expression, ")", @line, @column))
                @line += 1
                @column += 1
            
            ##################################################
            ##################################################
            
            # Arithmetic Operators

            # Add
            elsif input[@line] == "+"             
                @tokens.push(Token.new(Add, "+", @line, @column))
                @line += 1
                @column += 1
            # Subtract
            elsif input[@line] == "-"
                @tokens.push(Token.new(Subtract, "-", @line, @column))
                @line += 1
                @column += 1
            # Divide
            elsif input[@line] == "/"
                @tokens.push(Token.new(Division, "/", @line, @column))
                @line += 1
            # Multiply or Exponentiation
            elsif input[@line] == "*"
                if @line + 1 < input.length && input[@line + 1] == "*"
                    @column += 1
                    @tokens.push(Token.new(Exponentiation, "**", @line, @column))
                    @line += 2
                    @column += 1
                else      
                    @tokens.push(Token.new(Multiply, "*", @line, @column))
                    @line += 1
                    @column += 1
                end
            # Modulo
            elsif input[@line] == "%"
                @tokens.push(Token.new(Modulo, "%", @line, @column))
                @line += 1
                @column += 1

            ##################################################
            ##################################################

            # Relational Operators 
            
            # Less than or less than equal to or right shift
            elsif input[@line] == "<"
                if @line + 1 < input.length && input[@line + 1] == "="
                    @column += 1
                    @tokens.push(Token.new(LessThanEqual, "<=", @line, @column))
                    @line += 2
                    @column += 1
                elsif @line + 1 < input.length && input[@line + 1] == "<"
                    @column += 1
                    @tokens.push(Token.new(BitwiseRightShift, "<<", @line, @column))
                    @line += 2
                    @column += 1
                else            
                    @tokens.push(Token.new(LessThan, "<", @line, @column))
                    @line += 1
                    @column += 1
                end
            # Greater than or greater than equal to or left shift
            elsif input[@line] == ">"
                if @line + 1 < input.length && input[@line + 1] == "="
                    @column += 1
                    @tokens.push(Token.new(GreaterThanEqual, ">=", @line, @column))
                    @line += 2
                    @column += 1
                elsif @line + 1 < input.length && input[@line + 1] == ">"
                    @column += 1
                    @tokens.push(Token.new(BitwiseLeftShift, ">>", @line, @column))
                    @line += 2
                    @column += 1
                else                 
                    @tokens.push(Token.new(GreaterThan, ">", @line, @column))
                    @line += 1
                    @column += 1
                end
            # Equal to
            elsif input[@line] == "="
                if @line + 1 < input.length && input[@line + 1] == "="
                    @column += 1
                    @tokens.push(Token.new(Equals, "==", @line, @column))
                    @line += 2
                    @column += 1
                else
                    "ERROR: Invalid token '=' at line: #{@line} column: #{@column}"
                end  
            # Logical Not or not equal to
            elsif input[@line] == "!"
                if @line + 1 < input.length && input[@line + 1] == "="
                    @column += 1
                    @tokens.push(Token.new(NotEquals, "!=", @line, @column))
                    @line += 2
                    @column += 1
                else
                    @tokens.push(Token.new(Not, "!", @line, @column))
                    @line += 1
                    @column += 1
                end

            ##################################################
            ##################################################

            # Bitwise Operators
            
            # Bitwise And or Logical And
            elsif input[@line] == "&"
                if @line + 1 < input.length && input[@line + 1] == "&"
                    @column += 1
                    @tokens.push(Token.new(And, "&&", @line, @column))
                    @line += 2
                    @column += 1
                else
                    @tokens.push(Token.new(BitwiseAnd, "&", @line, @column))
                    @line += 1
                    @column += 1
                end        
            # Bitwise Or or Logical Or
            elsif input[@line] == "|"
                if @line + 1 < input.length && input[@line + 1] == "|"
                    @column += 1
                    @tokens.push(Token.new(Or, "||", @line, @column))
                    @line += 2
                    @column += 1
                else
                    @tokens.push(Token.new(BitwiseOr, "|", @line, @column))
                    @line += 1
                    @column += 1
                end
            # Bitwise Xor
            elsif input[@line] == "^"        
                @tokens.push(Token.new(BitwiseXor, "^", @line, @column))
                @line += 1
                @column += 1
            # Bitwise Not
            elsif input[@line] == "~"
                @tokens.push(Token.new(BitwiseNot, "~", @line, @column))
                @line += 1
                @column += 1
            
            ##################################################
            ##################################################

            # Number

            # If the next character is a digit, it's a number. Grab the whole number.
            elsif input[@line].match?(/\d/)
                number = ""
                number_line = @line

                # Lex a integer or float
                while @line < input.length && input[@line].match?(/\d/)
                    number += input[@line]
                    @line += 1
                    @column += 1
                end

                # If the next character is a period, it's a float. Grab the whole float.
                if @line < input.length && input[@line] == "."
                    number += input[@line]
                    @line += 1
                    @column += 1

                    while @line < input.length && input[@line].match?(/\d/)
                        number += input[@line]
                        @line += 1
                        @column += 1
                    end

                    @tokens.push(Token.new(FloatPrimitive, number, number_line, @column - 1))
                else
                    @tokens.push(Token.new(IntegerPrimitive, number, number_line, @column - 1))
                end
            
            ##################################################
            ##################################################

            # Cell Reference
            
            # Check if input matches hash symbol (#)
            elsif input[@line].match?(/\#/)
                # cell references are in the form: #[2, 3]
                @line += 1
                @column += 1

                reference = ""
                
                # Lex a cell reference in the form: #[2, 3] until the next character is a ]
                while @line < input.length && input[@line] != "]"
                    reference += input[@line]
                    @line += 1
                    @column += 1
                end

                reference += input[@line]
                @line += 1
                @column += 1
       
                ref_row, ref_col = reference[1..-2].split(",").map(&:to_i)

                if ref_row.to_i.to_s == ref_row || ref_col.to_i.to_s == ref_col
                    @error = "ERROR: Invalid cell reference at line: #{@line} column: #{@column}"
                    @validity = false
                    break
                end

                # puts "CELL ARRAY REFERENCE: #{ref_row} #{ref_col}"
                # puts
                @tokens.push(Token.new(CellReference, reference, @line - reference.length, @column))
         
            ##################################################
            ##################################################

            # Characters    (variable or boolean or function)

            elsif input[@line].match?(/[a-zA-Z]/)
                # Parse the word as a string
                word = ""
                while @line < input.length && input[@line].match?(/[a-zA-Z]/)
                    word += input[@line]
                    @line += 1
                    @column += 1
                end

                # Check if it's a variable or boolean
                if word == "true" || word == "false"
                    @tokens.push(Token.new(BooleanPrimitive, word, @line, @column + word.length))
                elsif @env.variables.has_key?(word)
                    @tokens.push(Token.new(Variable, word, 
                                    @line, @column + word.length))

                elsif word == "sum"
                    @tokens.push(Token.new(Sum, "sum",  @line - word.length, @column  - 1))
                elsif word == "min"
                    @tokens.push(Token.new(Min, "min",  @line - word.length, @column  - 1))
                elsif word == "max"
                    @tokens.push(Token.new(Max, "max",  @line - word.length, @column  - 1))
                elsif word == "mean"
                    @tokens.push(Token.new(Mean, "mean",  @line - word.length, @column  - 1))

                else
                    @error = "ERROR: Invalid variable: #{word} at line #{@line}"
                    @validity = false
                    break
                end

            ##################################################
            ##################################################

            # Error

            else
                @error = "ERROR: Invalid input: #{input[@line]} at line #{@line}"
                @validity = false
                break
            end
        end
    end

    # Print the tokens array. For debugging and proof of concept.
    def to_s
        puts "["
        @tokens.each do |token|
            puts "  #{token},"
        end
        puts "]"
    end

    # Get all tokens
    def all_tokens
        return @tokens
    end

end


##################################################
##################################################
##################################################
##################################################

class Parser 
    attr_accessor :tokens, :current_token, :ast, :validity, :error

    def initialize(tokens, env)
        @tokens = tokens
        @i = 0
        @ast = nil
        @curr_token = @tokens[@i]
        @validity = true
        @error = ""
        @env = env
    end

    # See the next token has a certain type
    def has(target) 
        return (@i < @tokens.length) && @tokens[@i].contents == target
    end

    # See if the next token farther along the entire expression has a certain type
    def has_ahead(target)     
        while @i < @tokens.length
            if @tokens[@i].contents == target
                return true
            end
        end
        return false
    end

    def advance
        # Move forward in the tokens list
        @i = @i + 1
        @curr_token = @tokens[@i]
    end

    def is_number 
        return @curr_token.type == IntegerPrimitive || 
                @curr_token.type == FloatPrimitive
    end

    def is_left_parenthesis
        return @curr_token.contents == "("
    end

    def is_right_parenthesis
        if @curr_token == nil
            return false
        end
        return @curr_token.contents == ")" 
    end

    def is_boolean
        return @curr_token.contents == "true" || @curr_token.contents == "false"
    end

    def is_cell
        return @curr_token.type == CellReference
    end

    def is_variable
        return @curr_token.type == Variable
    end

    def is_function
        return @curr_token.contents == "sum" || @curr_token.contents == "min" ||
                 @curr_token.contents == "max" || @curr_token.contents == "mean"
    end
   
    def create_number
        if @curr_token.type == IntegerPrimitive
            return IntegerPrimitive.new(@curr_token.contents.to_i)
        elsif @curr_token.type == FloatPrimitive
            return FloatPrimitive.new(@curr_token.contents.to_f)
        else
            return "ERROR: Invalid number at line: #{@curr_token.line}"
        end
    end

    ##################################################
    ##################################################

    # RECURSIVE DESCENT PARSING

    # PEMDAS AND OPERATOR PRECEDENCE

    def parse 
        @ast = expr
    end

    def expr
        logical_or
    end

    # Logical Or
    def logical_or
        left = logical_and
        while has('||')
            operator = @curr_token.contents
            advance
            right = logical_and
            left = Or.new(left, right)
        end
        return left
    end

    # Logical And
    def logical_and
        left = bitwise_or
        while has('&&')
            operator = @curr_token.contents
            advance
            right = bitwise_or
            left = And.new(left, right)
        end
        return left
    end

    # Bitwise Or
    def bitwise_or
        left = bitwise_xor
        while has('|')
            operator = @curr_token.contents
            advance
            right = bitwise_xor
            left = BitwiseOr.new(left, right)
        end
        return left
    end

    # Bitwise Xor
    def bitwise_xor
        left = bitwise_and
        while has('^')
            operator = @curr_token.contents
            advance
            right = bitwise_and
            left = BitwiseXor.new(left, right)
        end
        return left
    end

    # Bitwise And
    def bitwise_and
        left = equality
        while has('&')
            operator = @curr_token.contents
            advance
            right = equality
            left = BitwiseAnd.new(left, right)
        end
        return left
    end

    # Equality Operators
    def equality
        left = relational
        while has('==') || has('!=')
            operator = @curr_token.contents
            advance
            right = relational
            if operator == '=='
                left = Equals.new(left, right)
            elsif operator == '!='
                left = NotEquals.new(left, right)
            end
        end
        return left
    end

    # Relational Operators
    def relational
        left = shift
        while has('<') || has('>') || has('<=') || has('>=')
            operator = @curr_token.contents
            advance
            right = shift
            if operator == '<'
                left = LessThan.new(left, right)
            elsif operator == '>'
                left = GreaterThan.new(left, right)
            elsif operator == '<='
                left = LessThanEqual.new(left, right)
            elsif operator == '>='
                left = GreaterThanEqual.new(left, right)
            end
        end
        return left
    end

    # Shift Operators
    def shift
        left = additive
        while has('<<') || has('>>')
            operator = @curr_token.contents
            advance
            right = additive
            if operator == '<<'
                left = BitwiseLeftShift.new(left, right)
            elsif operator == '>>'
                left = BitwiseRightShift.new(left, right)
            end
        end
        return left
    end

    # Addition and Subtraction
    def additive
        left = multiplicative
        while has('+') || has('-')  
            operator = @curr_token.contents
            advance
            right = multiplicative
            if operator == '+'
                left = Add.new(left, right)
            elsif operator == '-'
                left = Subtract.new(left, right)
            end
        end
        return left
    end

    # Multiplication, Division, Modulo
    def multiplicative
        left = exponent
        while has('*') || has('/') || has('%') 
            operator = @curr_token.contents
            advance
            right = exponent
            if operator == '*'
                left = Multiply.new(left, right)
            elsif operator == '/'
                left = Division.new(left, right)
            elsif operator == '%'
                left = Modulo.new(left, right)
            end
        end
        return left
    end

    # Exponentiation
    def exponent
        left = nots
        while has('**')
            operator = @curr_token.contents
            advance
            right = nots
            left = Exponentiation.new(left, right)
        end
        return left
    end

    # Bitwise Not and Logical Not    
    def nots
        if has('!')
            operator = @curr_token.contents
            advance
            right = atom
            return Not.new(right)
        elsif has('~')
            operator = @curr_token.contents
            advance
            right = atom
            return BitwiseNot.new(right)
        else
            return atom
        end
    end

    # Atom
    def atom
        if is_left_parenthesis
            advance
            expr = logical_or
            if is_right_parenthesis
                advance
                return expr
            else
                @validity = false
                @error = "ERROR: Missing right parenthesis"
                return
            end
        elsif is_number
            curr_number = create_number
            advance
            return curr_number
        elsif is_boolean
            curr_boolean = BooleanPrimitive.new(@curr_token.contents)
            advance
            return curr_boolean
        elsif is_cell
            reference = @curr_token.contents
            reference = reference[1..-2]
            ref_row, ref_col = reference.split(",").map(&:to_i)
            if @env.cells.has_key?([ref_row, ref_col])
                ref_eval = @env.cells[[ref_row, ref_col]].evaluate(@env)
            else
                ref_eval = IntegerPrimitive.new(0)
            end
            advance
            return ref_eval
        elsif is_variable
            curr_variable = @env.variables[@curr_token.contents]
            advance
            return curr_variable
        elsif is_function
            puts "Function: #{@curr_token.contents}"
            function = @curr_token.contents
            advance
            left_addr = @curr_token.contents.to_s
            advance
            right_addr = @curr_token.contents.to_s
            computation = nil
            if function == "sum"
                computation = Sum.new(left_addr, right_addr)
            elsif function == "min"
                computation = Min.new(left_addr, right_addr)
            elsif function == "max"
                computation = Max.new(left_addr, right_addr)
            elsif function == "mean"
                computation = Mean.new(left_addr, right_addr)
            else 
                @validity = false
                @error = "ERROR: Invalid function #{function} at line #{@curr_token.line}"
                return 
            end   
            advance
            return computation
        else
            @validity = false 
            @error = "ERROR: Invalid atom at line #{@curr_token.line}"
            return 
        end
    end
end
