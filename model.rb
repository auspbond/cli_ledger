##################################################
##################################################

class Environment
    attr_accessor :grid, :variables, :cells

    def initialize(grid)
        @grid = grid
        @cells = grid.cells
        @variables = Hash.new   # For storing variables
        # Add constants to the environment 
        @variables["e"] = FloatPrimitive.new(Math::E)
        @variables["pi"] = FloatPrimitive.new(Math::PI)
        @variables["tau"] = FloatPrimitive.new(Math::PI * 2)
        @variables["gold"] = FloatPrimitive.new(1.6180339887498949)
        @variables["plastic"] = FloatPrimitive.new(1.324717957244746025)
        @variables["pythagoras"] = FloatPrimitive.new(Math::sqrt(2))
    end

    def print_variables()
        @variables.each do |key, exp|
            puts "#{key}: #{exp}"
        end
    end
end

##################################################
##################################################

class Expression 
    def evaluate(env)
        return "Not implemented"
    end
end

##################################################
##################################################

class Grid 
    attr_accessor :cells, :num_rows, :num_cols
    # Initialize a grid as a hashmap of rows and columns
    def initialize()
        @cells = Hash.new
        @num_rows = nil
        @num_cols = nil
    end

    # Get a cell from the grid
    def get_cell(row, column)
        @cells[[row, column]]
    end

    # Set a cell in the grid
    def set_cell(row, column, exp)
        @cells[[row, column]] = exp
    end

    def cellref_set_cell(cellref)
        @cells[[cellref.row, cellref.column]] = cellref.exp
    end

    # Print the grid
    def to_s
        @cells.each do |key, exp|
            puts "#{key}: #{exp} (#{exp.class})"
        end
    end

    def delete_cell(row, column)
        @cells.delete([row, column])
    end
end

##################################################
##################################################

class CellReference
    attr_accessor :row, :column, :exp

    def initialize(row, column)
        @row = row
        @col = column
        @exp = nil
    end

    def cell_coordinates
        [@row, @col]
    end

    def evaluate(env)
        env.grid.get_cell(@row, @col).evaluate(env)
    end

    def set_cell(exp)
        @exp = exp
    end

    def to_s
        "[#{@row}, #{@col}]"
    end

end

##################################################
##################################################f 
##################################################
##################################################


class IntegerPrimitive < Expression
    attr_accessor :value

    def initialize(value)
        # Check if value is a integer number
        if value.is_a?(Integer) == false
            return "Value must be a integer"
        end
        @value = value
    end

    def to_s
        @value.to_s
    end

    def evaluate(env)
        self
    end
end

class FloatPrimitive < Expression
    attr_accessor :value

    def initialize(value)
        # Check if value is a number
        if value.is_a?(Float) == false
            return "Value must be a float"
        end
        @value = value
    end

    def to_s
        @value.to_s
    end

    def evaluate(env)
        self
    end
end

class BooleanPrimitive < Expression
    attr_accessor :value

    def initialize(value)
        if value.to_s != "true" && value.to_s != "false"
            return "Value must be a boolean"
        end
        if value.to_s == "true"
            @value = true
        else
            @value = false
        end
    end

    def to_s
        @value.to_s
    end

    def evaluate(env)
        self
    end
end

class StringPrimitive < Expression
    attr_accessor :value

    def initialize(value)
        @value = value
    end

    def to_s
        @value.to_s
    end

    def evaluate(env)
        self
    end
end

class Variable < Expression     # Variable Class
    attr_accessor :name, :value

    def initialize(name, env)
        @name = name
        @value = env.variables[name]
    end

    def to_s
        @value.to_s
    end

    def evaluate(env)
        self
    end
end



##################################################
##################################################
##################################################
##################################################

class Operation < Expression
    attr_accessor :left, :right, :symbol

    def initialize(symbol, left, right)

        @symbol = symbol
        @left = left
        @right = right
    end
end

##################################################
##################################################
##################################################
##################################################

class ArithmeticOperation < Operation
    attr_accessor :left, :right, :symbol

    def initialize(symbol, left, right)

        # Check if an arithmetic operand was passed
        if !(symbol != '+' || symbol != '-' || symbol != '*' || 
            symbol != '/' || symbol != '%' || symbol != '**')
            return "Invalid arithmetic symbol"
        end
        if left == nil || right == nil
            return "Nil arithmetic operands"
        end
        
        @symbol = symbol
        @left = left
        @right = right
    end

    def to_s
        "(#{left.to_s} #{symbol} #{right.to_s})"
    end
    
    def to_s_expr
        "(#{symbol} #{left.to_s} #{right.to_s})"
    end

    def check_ints
        if @left.is_a?(IntegerPrimitive) && @right.is_a?(IntegerPrimitive)
            true
        else
            false
        end
    end

    def check_floats
        if @left.is_a?(FloatPrimitive) && @right.is_a?(FloatPrimitive)
            true
        else 
            false
        end
    end
end

##################################################
##################################################

class Add < ArithmeticOperation
    def initialize(left, right)
      super('+', left, right)
    end
    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) && @right_value.is_a?(IntegerPrimitive)
            IntegerPrimitive.new(@left_value.value + @right_value.value) 
        else
            FloatPrimitive.new(@left_value.value + @right_value.value)
        end
    end
end
  
class Subtract < ArithmeticOperation
    def initialize(left, right)
      super('-', left, right)
    end
    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) && @right_value.is_a?(IntegerPrimitive)
            IntegerPrimitive.new(@left_value.value - @right_value.value)
        else
            FloatPrimitive.new(@left_value.value - @right_value.value)
        end
    end
end

class Multiply < ArithmeticOperation
    def initialize(left, right)
      super('*', left, right)
    end
    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) && @right_value.is_a?(IntegerPrimitive)
            IntegerPrimitive.new(@left_value.value * @right_value.value)   
        else
            FloatPrimitive.new(@left_value.value * @right_value.value)
        end
    end
end
  
class Division < ArithmeticOperation
    def initialize(left, right)
      super('/', left, right)
    end
    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) && @right_value.is_a?(IntegerPrimitive)
            IntegerPrimitive.new(@left_value.value / @right_value.value)    
        else
            FloatPrimitive.new(@left_value.value / @right_value.value)
        end
    end
end

class Modulo < ArithmeticOperation
    def initialize(left, right)
      super('%', left, right)
    end
    def evaluate(env)

        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) && @right_value.is_a?(IntegerPrimitive)
            IntegerPrimitive.new(@left_value.value % @right_value.value)
        else
            FloatPrimitive.new(@left_value.value % @right_value.value)
        end
    end
end

class Exponentiation < ArithmeticOperation
    def initialize(left, right)
      super('**', left, right)
    end
    def evaluate(env)
        
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) && @right_value.is_a?(IntegerPrimitive)
            IntegerPrimitive.new(@left_value.value ** @right_value.value)     
        else
            FloatPrimitive.new(@left_value.value ** @right_value.value)
        end
    end
end

##################################################
##################################################
##################################################
##################################################

class LogicalOperation < Expression
    attr_accessor :left, :right, :symbol

    def initialize(symbol, left, right)

        @symbol = symbol
        @left = left
        @right = right 
    end

    def to_s
        "(#{left.to_s} #{symbol} #{right.to_s})"
    end
    
    def to_s_expr
        "(#{symbol} #{left.to_s} #{right.to_s})"
    end

end

##################################################
##################################################

class And < LogicalOperation
    def initialize(left, right)
      super('and', left, right)
    end

    def evaluate(env)
        @left_operation = @left.evaluate(env)
        if @left_operation.is_a?(BooleanPrimitive) == false
            return "Invalid left operand"
        end
        if @left_operation.value == false
            return BooleanPrimitive.new(false)
        else
            @right_operation = @right.evaluate(env)
            if @right_operation.is_a?(BooleanPrimitive) == false
                return "Invalid right operand"
            end
            return BooleanPrimitive.new(@right_operation.value)
        end
    end
end
  
class Or < LogicalOperation
    def initialize(left, right)
      super('or', left, right)
    end

    def evaluate(env)

        @left_operation = @left.evaluate(env)
        if @left_operation.is_a?(BooleanPrimitive) == false
            return "Invalid left operand"
        end
        if @left_operation.value == true
            return BooleanPrimitive.new(true)
        else
            @right_operation = @right.evaluate(env)
            if @right_operation.is_a?(BooleanPrimitive) == false
                return "Invalid right operand"
            end
            return BooleanPrimitive.new(@right_operation.value)
        end
    end
end

class Not < LogicalOperation
    def initialize(left)
      super('not', left, nil)
    end
    def evaluate(env)
        @left_operation = @left.evaluate(env)
        if @left_operation.is_a?(BooleanPrimitive) == false
            return "Invalid left operand"
        end
        BooleanPrimitive.new(!@left_operation.value)
    end

    def to_s
        "#{symbol} #{left.to_s}"
    end
end

##################################################
##################################################
##################################################
##################################################

class BitwiseOperation < Operation
    attr_accessor :left, :right, :symbol

    def initialize(symbol, left, right)

        if (symbol != '&' && symbol != '|' && symbol != '~' && symbol != '^' && 
            symbol != '>>' && symbol != '<<')
            return "Invalid bitwise symbol"
        end
        @symbol = symbol
        @left = left
        @right = right 
    end

    def to_s
        "(#{left.to_s} #{symbol} #{right.to_s})"
    end

    def to_s_expr
        "(#{symbol} #{left.to_s} #{right.to_s})"
    end  
end

class BitwiseAnd < BitwiseOperation
    def initialize(left, right)
      super('&', left, right)
    end

    def evaluate(env)
        
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false || 
            @right_value.is_a?(IntegerPrimitive) == false
            return "Invalid operands"
        end
        IntegerPrimitive.new(@left_value.value & @right_value.value)
    end
end
  
class BitwiseOr < BitwiseOperation
    def initialize(left, right)
      super('|', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false || 
            @right_value.is_a?(IntegerPrimitive) == false
            return "Invalid operands"
        end
        IntegerPrimitive.new(@left_value.value | @right_value.value)
    end
end

class BitwiseXor < BitwiseOperation
    def initialize(left, right)
      super('^', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false || 
            @right_value.is_a?(IntegerPrimitive) == false
            return "Invalid operands"
        end
        IntegerPrimitive.new(@left_value.value ^ @right_value.value)
    end
end

class BitwiseNot < BitwiseOperation
    def initialize(left)
      super('~', left, nil)
    end
    def evaluate(env)
        @left_value = @left.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false
            return "Invalid operand"
        end
        IntegerPrimitive.new(~@left_value.value)
    end

    def to_s
        "#{symbol} #{left.to_s}"
    end
end

class BitwiseLeftShift < BitwiseOperation
    def initialize(left, right)
      super('<<', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)   
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false || 
            @right_value.is_a?(IntegerPrimitive) == false
            return "Invalid operands"
        end
        IntegerPrimitive.new(@left_value.value << @right_value.value)
    end
end

class BitwiseRightShift < BitwiseOperation
    def initialize(left, right)
      super('>>', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false || 
            @right_value.is_a?(IntegerPrimitive) == false
            return "Invalid operands"
        end
        IntegerPrimitive.new(@left_value.value >> @right_value.value)
    end
end

##################################################
##################################################
##################################################
##################################################

class RelationalOperation < Operation
    attr_accessor :left, :right, :symbol

    def initialize(symbol, left, right)

        if (symbol != '<' && symbol != '<=' && symbol != '>' && symbol != '>=' && 
            symbol != '==' && symbol != '!=') || symbol == nil
            return "Invalid relational symbol"
        end
        @symbol = symbol
        @left = left
        @right = right 
    end

    def to_s
        "(#{left.to_s} #{symbol} #{right.to_s})"
    end

    def to_s_expr
        "(#{symbol} #{left.to_s} #{right.to_s})"
    end  
end

class Equals < RelationalOperation
    def initialize(left, right)
      super('==', left, right)
    end

    def evaluate(env)

        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false && 
            @left_value.is_a?(FloatPrimitive) == false
            return "Invalid left operand"
        elsif @right_value.is_a?(IntegerPrimitive) == false && 
            @right_value.is_a?(FloatPrimitive) == false
            return "Invalid right operand"
        else
            BooleanPrimitive.new(@left_value.value == @right_value.value)
        end
    end
end
  
class NotEquals < RelationalOperation
    def initialize(left, right)
      super('!=', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false && 
            @left_value.is_a?(FloatPrimitive) == false
            return "Invalid left operand"
        elsif @right_value.is_a?(IntegerPrimitive) == false && 
            @right_value.is_a?(FloatPrimitive) == false
            return "Invalid right operand"
        else
            BooleanPrimitive.new(@left_value.value != @right_value.value)
        end
    end
end

class LessThan < RelationalOperation
    def initialize(left, right)
      super('<', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false && 
            @left_value.is_a?(FloatPrimitive) == false
            return "Invalid left operand"
        elsif @right_value.is_a?(IntegerPrimitive) == false && 
            @right_value.is_a?(FloatPrimitive) == false
            return "Invalid right operand"
        else
            BooleanPrimitive.new(@left_value.value < @right_value.value)
        end
    end
end
  
class LessThanEqual < RelationalOperation
    def initialize(left, right)
      super('<=', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false && 
            @left_value.is_a?(FloatPrimitive) == false
            return "Invalid left operand"
        elsif @right_value.is_a?(IntegerPrimitive) == false && 
            @right_value.is_a?(FloatPrimitive) == false
            return "Invalid right operand"
        else
            BooleanPrimitive.new(@left_value.value <= @right_value.value)
        end
    end
end

class GreaterThan < RelationalOperation
    def initialize(left, right)
      super('>', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false && 
            @left_value.is_a?(FloatPrimitive) == false
            return "Invalid left operand"
        elsif @right_value.is_a?(IntegerPrimitive) == false && 
            @right_value.is_a?(FloatPrimitive) == false
            return "Invalid right operand"
        else
            BooleanPrimitive.new(@left_value.value > @right_value.value)
        end
    end
end

class GreaterThanEqual < RelationalOperation
    def initialize(left, right)
      super('>=', left, right)
    end

    def evaluate(env)
        @left_value = @left.evaluate(env)
        @right_value = @right.evaluate(env)

        if @left_value.is_a?(IntegerPrimitive) == false && 
            @left_value.is_a?(FloatPrimitive) == false
            return "Invalid left operand"
        elsif @right_value.is_a?(IntegerPrimitive) == false && 
            @right_value.is_a?(FloatPrimitive) == false
            return "Invalid right operand"
        else
            BooleanPrimitive.new(@left_value.value >= @right_value.value)
        end
    end
end

##################################################
##################################################
##################################################
##################################################

# float to int cast
def float_to_int(float)
    IntegerPrimitive.new(float.to_i)
end

# int to float cast
def int_to_float(int)
    FloatPrimitive.new(int.to_f)
end

##################################################
##################################################
##################################################
##################################################

# Function Classes

# DO NOT CREATE A FUNCTION WITHIN ITS OWN RANGE

class Function < Expression
    attr_accessor :expressions, :type, :start_addr, :end_addr

    def initialize(start_addr, end_addr, type)
        @expressions = []
        @type = type
        @start_addr = start_addr
        @end_addr = end_addr
        @error = ""
    end

    def to_s
        "(#{type} #{start_addr} #{end_addr})"
    end

    def to_s_expr
        @expressions.each do |expr|
            expr.to_s
        end 
    end

    def extract(env)
        expressions = []

        start_addr = @start_addr[1..-2]
        end_addr = @end_addr[1..-2]
        start_addr_row, start_addr_col = start_addr.split(',').map(&:to_i)
        end_addr_row, end_addr_col = end_addr.split(',').map(&:to_i)

        if end_addr_row == start_addr_row
            row = start_addr_row
            for col in start_addr_col..end_addr_col
                if env.cells.has_key?([row, col])
                    expressions.push(env.grid.cells[[row, col]])
                else
                    @error = "INVALID FUNCTION. PROBLEM CELL: [#{row}, #{col}] "
                    break
                end
            end
        else
            for row in start_addr_row..end_addr_row
                num_cols = env.grid.num_cols
                if row == end_addr_row
                    num_cols = end_addr_col
                end
                if row == start_addr_row
                    for col in start_addr_col..num_cols
                        if env.cells.has_key?([row, col])
                            expressions.push(env.grid.cells[[row, col]])
                        else 
                            @error = "INVALID FUNCTION. PROBLEM CELL: [#{row}, #{col}] "
                            break
                        end
                    end
                else
                    for col in 0..num_cols
                        if env.cells.has_key?([row, col])
                            expressions.push(env.grid.cells[[row, col]])
                        else
                            @error = "INVALID FUNCTION. PROBLEM CELL: [#{row}, #{col}] "
                            break
                        end
                    end
                end
            end
        end

        expressions.each do |expr|
            # check if each expression is a float or int
            evaluated = expr.evaluate(env)
            if evaluated.is_a?(FloatPrimitive) == false && 
                evaluated.is_a?(IntegerPrimitive) == false
                # puts "INVALID SUMMATION. PROBLEM EXPR: #{expr}"
                @error = "INVALID SUMMATION. PROBLEM EXPR: #{expr}"
                return 
            end
        end

        if @error.empty?
            @expressions = expressions
        end
    end

end

class Sum < Function

    def initialize(start_addr, end_addr)
        super(start_addr, end_addr, "sum")
    end

    def evaluate(env)
        extract(env)
        # puts @expressions
        if @error.empty? == false
            # puts "INVALID SUMMATION. PROBLEM EXPR: #{@expressions}"
            return StringPrimitive.new("#{@error}")
        end
        sum = 0
        # From left to right, sum all the grid cells
        @expressions.each do |expr|
            evaluated = expr.evaluate(env)
            sum += expr.evaluate(env).value
        end
        if sum.to_s.to_i == sum
            return IntegerPrimitive.new(sum)
        else
            return FloatPrimitive.new(sum)
        end
    end
end

class Min < Function

    def initialize(start_addr, end_addr)
        super(start_addr, end_addr, "min")
    end

    def evaluate(env)
        extract(env)
        # puts @expressions
        if @error.empty? == false
            # puts "INVALID SUMMATION. PROBLEM EXPR: #{@expressions}"
            return StringPrimitive.new("#{@error}")
        end
        min = @expressions[0].evaluate(env).value
        @expressions.each do |expr|
            evaluated = expr.evaluate(env)
            if expr.evaluate(env).value < min
                min = expr.evaluate(env).value
            end
        end
        if min.to_s.to_i == min
            return IntegerPrimitive.new(min)
        else
            return FloatPrimitive.new(min)
        end
    end
end

class Max < Function

    def initialize(start_addr, end_addr)
        super(start_addr, end_addr, "max")
    end

    def evaluate(env)
        extract(env)
        # puts @expressions
        if @error.empty? == false
            # puts "INVALID SUMMATION. PROBLEM EXPR: #{@expressions}"
            return StringPrimitive.new("#{@error}")
        end
        max = @expressions[0].evaluate(env).value
        @expressions.each do |expr|
            evaluated = expr.evaluate(env)
            if expr.evaluate(env).value > max
                max = expr.evaluate(env).value
            end
        end
        if max.to_s.to_i == max
            return IntegerPrimitive.new(max)
        else
            return FloatPrimitive.new(max)
        end
    end
end

class Mean < Function

    def initialize(start_addr, end_addr)
        super(start_addr, end_addr, "mean")
    end

    def evaluate(env)
        extract(env)
        # puts @expressions
        if @error.empty? == false
            # puts "INVALID SUMMATION. PROBLEM EXPR: #{@expressions}"
            return StringPrimitive.new("#{@error}")
        end
        sum = 0
        for expr in @expressions
            evaluated = expr.evaluate(env)
            sum += expr.evaluate(env).value
        end
        mean = (sum.to_f / @expressions.length.to_f).to_f
        return FloatPrimitive.new(mean)
    end
end








# # env tests
# grid = Grid.new()
# test_env = Environment.new(grid)
# ref = CellReference.new(1, 3)


# # arithmetic tests
# two_plus_two = Add.new(FloatPrimitive.new(2.0), FloatPrimitive.new(2.0))
# three_times_three = Multiply.new(FloatPrimitive.new(3.0), FloatPrimitive.new(3.0))
# puts "Two plus two"
# puts two_plus_two.to_s
# puts "Three times three"
# puts three_times_three.to_s
# puts two_plus_two.evaluate(test_env).to_s


# grid.set_cell(1, 3, two_plus_two)

# merge = Add.new(two_plus_two, three_times_three)
# puts "Merge"
# puts merge.left.to_s
# puts merge.right.to_s
# puts merge.to_s
# puts merge.evaluate(test_env).to_s
# puts 

# two_plus_two_bad = Add.new(FloatPrimitive.new(2.0), IntegerPrimitive.new(2))

# # three_times_three_bad = Multiply.new(FloatPrimitive.new(3.0), 3.0)

# puts "Bad arithmetic"
# puts two_plus_two_bad.to_s
# # merge_bad = Add.new(two_plus_two_bad, three_times_three)
# puts 
# merge_subtract = Subtract.new(two_plus_two, FloatPrimitive.new(9.0))
# puts "Merge subtract"
# puts merge_subtract.to_s
# # puts merge_subtract.evaluate.to_s
# puts
# double_merge = Add.new(merge, merge)
# puts "Double merge"
# puts double_merge.to_s
# # puts double_merge.evaluate.to_s
# puts
# triple_merge = Add.new(merge, double_merge)
# puts "Triple merge"
# puts triple_merge.to_s
# puts triple_merge.evaluate(test_env).to_s
# puts

# # boolean tests
# true_and_false = And.new(BooleanPrimitive.new(true), BooleanPrimitive.new(false))
# false_or_true = Or.new(BooleanPrimitive.new(false), BooleanPrimitive.new(true))
# puts "Boolean expressions"
# puts true_and_false.to_s
# puts false_or_true.to_s
# puts
# boolean_merge = And.new(true_and_false, false_or_true)

# puts "Boolean merge"
# puts boolean_merge.to_s
# puts boolean_merge.evaluate(test_env).to_s
# puts


# puts "Cell reference Arithmetic Expression"
# puts ref.get_expression(test_env).to_s
# puts
# puts "Cell reference evaluate"
# puts ref.evaluate(test_env)
# puts

# grid.set_cell(1, 4, true_and_false)
# puts "Cell reference Boolean"
# puts grid.get_cell(1, 4).to_s
# puts

# # bitwise tests
# bitwise_and = BitwiseAnd.new(IntegerPrimitive.new(2), IntegerPrimitive.new(67))
# bitwise_or = BitwiseOr.new(IntegerPrimitive.new(35), IntegerPrimitive.new(3))
# bitwise_xor = BitwiseXor.new(IntegerPrimitive.new(2), IntegerPrimitive.new(53))
# bitwise_not = BitwiseNot.new(IntegerPrimitive.new(2))
# bitwise_shift_left = BitwiseLeftShift.new(IntegerPrimitive.new(2), IntegerPrimitive.new(77))
# bitwise_shift_right = BitwiseRightShift.new(IntegerPrimitive.new(2), IntegerPrimitive.new(98))

# puts "Bitwise tests"
# puts bitwise_and.to_s
# puts bitwise_and.evaluate(test_env).to_s
# puts bitwise_or.to_s
# puts bitwise_or.evaluate(test_env).to_s
# puts bitwise_xor.to_s
# puts bitwise_xor.evaluate(test_env).to_s
# puts bitwise_not.to_s
# puts bitwise_not.evaluate(test_env).to_s
# puts bitwise_shift_left.to_s
# puts bitwise_shift_left.evaluate(test_env).to_s
# puts bitwise_shift_right.to_s
# puts bitwise_shift_right.evaluate(test_env).to_s
# puts

# # relational tests
# equals = Equals.new(IntegerPrimitive.new(2), IntegerPrimitive.new(67))
# not_equals = NotEquals.new(IntegerPrimitive.new(35), IntegerPrimitive.new(3))
# less_than = LessThan.new(IntegerPrimitive.new(2), IntegerPrimitive.new(67))
# less_than_equal = LessThanEqual.new(IntegerPrimitive.new(35), IntegerPrimitive.new(3))
# greater_than = GreaterThan.new(IntegerPrimitive.new(222), IntegerPrimitive.new(53))
# greater_than_equal = GreaterThanEqual.new(IntegerPrimitive.new(2), IntegerPrimitive.new(98))

# puts "Relational tests"
# puts equals.to_s
# puts equals.evaluate(test_env).to_s
# puts not_equals.to_s
# puts not_equals.evaluate(test_env).to_s
# puts less_than.to_s
# puts less_than.evaluate(test_env).to_s
# puts less_than_equal.to_s
# puts less_than_equal.evaluate(test_env).to_s
# puts greater_than.to_s
# puts greater_than.evaluate(test_env).to_s
# puts greater_than_equal.to_s
# puts greater_than_equal.evaluate(test_env).to_s
# puts

# # cast tests
# puts "Cast tests"
# puts int_to_float(IntegerPrimitive.new(55)).to_s
# puts float_to_int(FloatPrimitive.new(52.0)).to_s
# puts


# # more env tests
# grid.set_cell(1, 5, equals)
# puts "Cell reference relational"
# puts grid.get_cell(1, 5).to_s
# puts
# # print grid
# puts "Grid"
# puts grid.to_s


# Create an environment and print the variables
# grid = Grid.new()
# env = Environment.new(grid)
# # print all env variables
# # env.print_variables

# grid.num_rows = 10
# grid.num_cols = 10

# # populate the grid with number 1
# 0 .upto(grid.num_rows - 1) do |row|
#   0 .upto(grid.num_cols - 1) do |col|
#     grid.set_cell(row, col, IntegerPrimitive.new(1))
#   end
# end

# grid.set_cell(4, 8, BooleanPrimitive.new(true))

# # print the grid
# # puts grid.to_s

# # 4 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
# # 5 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# sum = Sum.new("[4, 4]", "[5, 4]")
# puts sum.evaluate(env).to_s



