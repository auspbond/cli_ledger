require_relative 'interpreter.rb'


grid = Grid.new()
test_env = Environment.new(grid)
ref1 = CellReference.new(1, 3)
ref2 = CellReference.new(2, 3)

# # Tests

# ##################################################
# ##################################################
# puts 
# puts "##################################################"
# puts "##################################################"
# puts 
# puts "TESTS"
# puts
# puts
# puts "Input: 5.5"
# puts
# input = "5 + 5"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# puts "PARSER OUTPUT:"
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)

# ##################################################
# ##################################################

# puts
# puts "##################################################"
# puts
# puts "Input: ((55.55 * (5 + 5.0)))"
# puts
# # invalid character
# input = "((55.55 * (#{int_to_float(5)} + 5.0)))"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"

# ##################################################
# ##################################################

# puts
# puts "Input: 2 * 2 ** (3 - 6 / 2)"
# puts
# # invalid character
# input = "2 * 2 ** (3 - 6 / 2)"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts 

# ##################################################
# ##################################################

# puts
# puts "Input: ((8 % 3) * 8 ** 2) / 4"
# puts
# # invalid character
# input = "((8 % 3) * 8 ** 2) / 4"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts 

# #################################################
# #################################################

# puts
# puts "Input: !false"
# puts
# # invalid character
# input = "!false"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts 

# ##################################################
# ##################################################

# puts
# puts "Input: false || true && !true"
# puts
# # invalid character
# input = "false || true && !true"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts 

# ##################################################
# ##################################################

# puts
# puts "Input: false || true && !true"
# puts
# # invalid character
# input = "false || true && !true"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts

# ##################################################
# ##################################################

# puts
# puts "Input: 5 ^ 3"
# puts
# # invalid character
# input = "5 ^ 3"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts

# ##################################################
# ##################################################

# puts
# puts "Input: 6 & 7 | ~8 ^ 9"
# puts
# # invalid character
# input = "6 & 7 | ~8 ^ 9"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts

# ##################################################
# ##################################################

# puts
# puts "Input: 15 == 15 && 5 != 15"
# puts
# # invalid character
# input = "15 == 15 && 5 != 15"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts

# ##################################################
# ##################################################

# puts
# puts "Input: 5 < 10 && 5 > 10 || 5 <= 10 && 5 >= 10"
# puts
# # invalid character
# input = "5 < 10 && 5 > 10 || 5 <= 10 && 5 >= 10"
# #        0123456789
# test_lexer = Lexer.new(input, test_env)
# test_lexer.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer.to_s
# puts
# test_parser = Parser.new(test_lexer.all_tokens)
# test_parser.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser.ast
# puts test_parser.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts

# ##################################################
# ##################################################

# puts
# puts "Input: 32 << 2 >> 4.0"
# puts
# # invalid character
# input = "32 << 2 >> #{float_to_int(4.0)}"
# #        0123456789
# test_lexer_2 = Lexer.new(input, test_env)
# test_lexer_2.lex(input)
# puts "LEXER OUTPUT:"
# puts
# test_lexer_2.to_s
# puts
# test_parser_2 = Parser.new(test_lexer_2.all_tokens)
# test_parser_2.parse
# puts "PARSER OUTPUT:"
# puts
# puts test_parser_2.ast
# puts test_parser_2.ast.evaluate(test_env)
# puts
# puts "##################################################"
# puts

# ##################################################
# ##################################################

# ref1.set_cell(test_parser.ast)
# ref2.set_cell(test_parser_2.ast)

# puts "Cell " + ref1.to_s
# puts "Cell " + ref2.to_s

# ##################################################
# ##################################################
# ##################################################
# ##################################################

puts

puts
puts "Input: pi + tau + e + gold + plastic + pythagoras"
puts
# invalid character
input = "pi + tau + e + gold + plastic + pythagoras"
#        0123456789
test_lexer_3 = Lexer.new(input, test_env)
test_lexer_3.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer_3.to_s
puts
test_parser_3 = Parser.new(test_lexer_3.all_tokens, test_env)
test_parser_3.parse
puts "PARSER OUTPUT:"
puts
puts test_parser_3.ast
puts test_parser_3.ast.evaluate(test_env)
puts
puts "##################################################"
puts

##################################################
##################################################

puts

# grid.cellref_set_cell(ref2)
grid.set_cell(5, 6, test_parser_3.ast)
puts "Cell [5, 6]: " + grid.get_cell(ref2.row, ref2.column).to_s
puts
puts "Input: (1 + e) + #[5, 6]"
puts
# invalid character
input = "(1 + e) + #[5, 6]"
#        0123456789
test_lexer_3 = Lexer.new(input, test_env)
test_lexer_3.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer_3.to_s
puts
test_parser_3 = Parser.new(test_lexer_3.all_tokens, test_env)
test_parser_3.parse
puts "PARSER OUTPUT:"
puts
puts test_parser_3.ast
puts test_parser_3.ast.evaluate(test_env)
puts
puts "##################################################"
puts

##################################################
##################################################

grid.num_rows = 10
grid.num_cols = 10

# populate the grid with number 1
0 .upto(grid.num_rows) do |row|
  0 .upto(grid.num_cols) do |col|
    grid.set_cell(row, col, IntegerPrimitive.new(2))
  end
end

puts
puts "Input: sum #[4, 5] #[5, 4] "
puts
# invalid character
input = "sum #[4, 5] #[5, 4]"
#        0123456789
test_lexer_3 = Lexer.new(input, test_env)
test_lexer_3.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer_3.to_s
puts
test_parser_3 = Parser.new(test_lexer_3.all_tokens, test_env)
test_parser_3.parse
puts "PARSER OUTPUT:"
puts
puts test_parser_3.ast
puts test_parser_3.ast.evaluate(test_env)
puts
puts "##################################################"
puts

##################################################
##################################################

grid.num_rows = 10
grid.num_cols = 10

# populate the grid with number 1
0 .upto(grid.num_rows) do |row|
  0 .upto(grid.num_cols) do |col|
    grid.set_cell(row, col, IntegerPrimitive.new(2))
  end
end

grid.set_cell(4, 9, IntegerPrimitive.new(7))

puts
puts "Input: max #[4, 5] #[5, 4] "
puts
# invalid character
input = "max #[4, 5] #[5, 4]"
#        0123456789
test_lexer_3 = Lexer.new(input, test_env)
test_lexer_3.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer_3.to_s
puts
test_parser_3 = Parser.new(test_lexer_3.all_tokens, test_env)
test_parser_3.parse
puts "PARSER OUTPUT:"
puts
puts test_parser_3.ast
puts test_parser_3.ast.evaluate(test_env)
puts
puts "##################################################"
puts

##################################################
##################################################

grid.num_rows = 10
grid.num_cols = 10

# populate the grid with number 1
0 .upto(grid.num_rows) do |row|
  0 .upto(grid.num_cols) do |col|
    grid.set_cell(row, col, IntegerPrimitive.new(5))
  end
end

grid.set_cell(4, 9, IntegerPrimitive.new(2))

puts
puts "Input: min #[4, 5] #[5, 4] "
puts
# invalid character
input = "min #[4, 5] #[5, 4]"
#        0123456789
test_lexer_3 = Lexer.new(input, test_env)
test_lexer_3.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer_3.to_s
puts
test_parser_3 = Parser.new(test_lexer_3.all_tokens, test_env)
test_parser_3.parse
puts "PARSER OUTPUT:"
puts
puts test_parser_3.ast
puts test_parser_3.ast.evaluate(test_env)
puts
puts "##################################################"
puts

##################################################
##################################################

grid.num_rows = 10
grid.num_cols = 10

# populate the grid with number 1
0 .upto(grid.num_rows) do |row|
  0 .upto(grid.num_cols) do |col|
    grid.set_cell(row, col, IntegerPrimitive.new(row + col))
  end
end

puts
puts "Input: mean #[4, 5] #[5, 4]"
puts
# invalid character
input = "mean #[4, 5] #[5, 4]"
#        0123456789
test_lexer_3 = Lexer.new(input, test_env)
test_lexer_3.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer_3.to_s
puts
test_parser_3 = Parser.new(test_lexer_3.all_tokens, test_env)
test_parser_3.parse
puts "PARSER OUTPUT:"
puts
puts test_parser_3.ast
puts test_parser_3.ast.evaluate(test_env)
puts
puts "##################################################"
puts