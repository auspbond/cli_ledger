require_relative 'interpreter.rb'


grid = Grid.new()
test_env = Environment.new(grid)
ref1 = CellReference.new(1, 3)
ref2 = CellReference.new(2, 3)

# Tests

##################################################
##################################################
puts 
puts "##################################################"
puts "##################################################"
puts 
puts "BROKEN TESTS"
puts
puts
# puts "Input: 5.5.0"
# puts
# input = "5 + 5"
# #        0123456789
# test_lexer = Lexer.new(input)
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

##################################################
##################################################

# puts
# puts "##################################################"
# puts
# puts "Input: ((55.55 * (5 + 5.0)"
# puts
# # invalid character
# input = "((55.55 * (#{int_to_float(5)} + 5.0)"
# #        0123456789
# test_lexer = Lexer.new(input)
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

##################################################
##################################################

puts
puts "Input: 2 **** 2 ** (3 - 6 / 2)"
puts
# invalid character
input = "2 * 2 **** (3 - 6 / 2)"
#        0123456789
test_lexer = Lexer.new(input)
test_lexer.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer.to_s
puts
test_parser = Parser.new(test_lexer.all_tokens)
test_parser.parse
puts "PARSER OUTPUT:"
puts
puts test_parser.ast
puts test_parser.ast.evaluate(test_env)
puts
puts "##################################################"
puts 

##################################################
##################################################

# puts
# puts "Input: ((8 % 3) @ 8 ** 2) / 4"
# puts
# # invalid character
# input = "((8 % 3) @ 8 ** 2) / 4"
# #        0123456789
# test_lexer = Lexer.new(input)
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

#################################################
#################################################

# puts
# puts "Input: !false"
# puts
# # invalid character
# input = "!false && 5"
# #        0123456789
# test_lexer = Lexer.new(input)
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

##################################################
##################################################

# puts
# puts "Input: false | true & !true"
# puts
# # invalid character
# input = "false | true & !true"
# #        0123456789
# test_lexer = Lexer.new(input)
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

##################################################
##################################################

# puts
# puts "Input: false || true && !true"
# puts
# # invalid character
# input = "#{float_to_int(false)} || true && !true"
# #        0123456789
# test_lexer = Lexer.new(input)
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

##################################################
##################################################

# puts
# puts "Input: 5.5 ^ 3"
# puts
# # invalid character
# input = "5.5 ^ 3"
# #        0123456789
# test_lexer = Lexer.new(input)
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

##################################################
##################################################

# puts
# puts "Input: 6 & 7 | ~8 ^ 9 2 ** 4"
# puts
# # invalid character
# input = "6 & 7 | ~8 ^ 9 2 ** 4"
# #        0123456789
# test_lexer = Lexer.new(input)
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

##################################################
##################################################

puts
puts "Input: 15 == 15 && 5 !== 15"
puts
# invalid character
input = "15 == 15 && 5 !== 15"
#        0123456789
test_lexer = Lexer.new(input)
test_lexer.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer.to_s
puts
test_parser = Parser.new(test_lexer.all_tokens)
test_parser.parse
puts "PARSER OUTPUT:"
puts
puts test_parser.ast
puts test_parser.ast.evaluate(test_env)
puts
puts "##################################################"
puts

##################################################
##################################################

puts
puts "Input: 5 < 10 && 5 > 10 ||"
puts
# invalid character
input = "5 < 10 && 5 > 10 ||"
#        0123456789
test_lexer = Lexer.new(input)
test_lexer.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer.to_s
puts
test_parser = Parser.new(test_lexer.all_tokens)
test_parser.parse
puts "PARSER OUTPUT:"
puts
puts test_parser.ast
puts test_parser.ast.evaluate(test_env)
puts
puts "##################################################"
puts

##################################################
##################################################

puts
puts "Input: 32 << 2 >> 4.0"
puts
# invalid character
input = "32 << 2 >> 4.0"
#        0123456789
test_lexer_2 = Lexer.new(input)
test_lexer_2.lex(input)
puts "LEXER OUTPUT:"
puts
test_lexer_2.to_s
puts
test_parser_2 = Parser.new(test_lexer_2.all_tokens)
test_parser_2.parse
puts "PARSER OUTPUT:"
puts
puts test_parser_2.ast
puts test_parser_2.ast.evaluate(test_env)
puts
puts "##################################################"
puts

##################################################
##################################################

ref1.set_cell(test_parser.ast)
ref2.set_cell(test_parser_2.ast)

puts "Cell " + ref1.to_s
puts "Cell " + ref2.to_s

