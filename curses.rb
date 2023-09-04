require_relative 'interpreter.rb'
require 'curses'

class Grapher
    def initialize(env)
        @line = 0
        @rows = nil
        @cols = nil
        @interface = nil
        @grid_window = nil
        @display_window = nil
        @formula_window = nil
        @user_formulas = Hash.new
        @env = env
        @grid = env.grid
    end

    def draw_interface

        # Initialize the screen BEFORE getting screen information
        Curses::init_screen
        Curses::noecho

        @rows = (Curses::lines / 4) - 2
        @cols = (Curses::cols / 10) - 1

        puts "Rows: #{@rows}"
        puts "Cols: #{@cols}"

        @grid.num_rows = @rows  # milestone 4
        @grid.num_cols = @cols  # milestone 4


        @interface = Curses::Window.new(Curses::lines, Curses::cols, 0, 0)

        # create a grid window that's half screen height and full screen width
        @grid_window = @interface.subwin((Curses::lines / 2) - 1, Curses::cols, 0, 0)
        # create a display window that's to the bottom left of the grid window 
        @display_window = @interface.subwin(Curses::lines / 8, Curses::cols, Curses::lines / 2, 0)
        # create a formula window that's to the bottom right of the grid window 
        @formula_window = @interface.subwin(Curses::lines / 8, Curses::cols, Curses::lines / 1.575, 0)

        # draw window borders
        @grid_window.box("|", "-")
        @formula_window.box("|", "-")
        @display_window.box("|", "-")

        # Give windows a title. Center a title at the top of each window
        @display_title = "Display Window"
        @formula_title = "Formula Editor"
        @display_window.setpos(1, (Curses::cols / 2) - (@display_title.length / 2) - 4)
        @display_window.addstr(@display_title)
        @formula_window.setpos(1, (Curses::cols / 2) - (@formula_title.length / 2) - 4)
        @formula_window.addstr(@formula_title)

        @grid_window.setpos(0, 0)

        # draw the cells for the grid 
        # each cell should be 10x2
        # vertical pipes and horizontal dashes
        for i in 1..(Curses::lines / 2) - 2
            if i % 2 == 0
                @grid_window.setpos(i, 1)
                @grid_window.addstr("-" * (Curses::cols - 2))
            end
            for j in 0..(Curses::cols) - 2
                    if j % 10 == 0
                        @grid_window.setpos(i, j)
                        @grid_window.addstr("|")
                    end
            end
        end
        
        @grid_window.setpos(1, 1)
        @interface.refresh
        @grid_window.refresh
        @display_window.refresh
        @formula_window.refresh
        @interface.keypad(true)
        @grid_window.keypad(true)   
        @formula_window.keypad(true)
        @display_window.keypad(true)

        activate

        Curses::close_screen
    end

    # Handle the user input. This is called after the interface is drawn.
    def activate

        curr_row = 0
        curr_col = 0

        # turn off echo so displayed input can be controlled
        Curses::noecho

        # WHY ARE ARROW KEYS NOT REGISTERING IN CURSES?
        # Ex. Curses::KEY_UP <<<<< DOES NOT WORK
        
        # loop until the user presses escape
        while true
            
            update_display(curr_row, curr_col)
            update_formula(curr_row, curr_col)
            update_cursor(curr_row, curr_col, false)
            input = nil
            case input = @grid_window.getch
                # if escape is pressed then exit the program  
                when 27
                    break
                # if w is pressed then move the current cell up one row
                when "w"
                    # puts "up"
                    if curr_row >= 1
                        clear_cell(curr_row, curr_col)
                        curr_row -= 1
                    end

                # if s is pressed then move the current cell down one row
                when "s"
                    # puts "down"
                    if curr_row < @rows
                        clear_cell(curr_row, curr_col)
                        curr_row += 1
                    end

                # if a is pressed then move the current cell left one column
                when "a"
                    # puts "left"
                    if curr_col >= 1
                        clear_cell(curr_row, curr_col)
                        curr_col -= 1
                    end

                # if d is pressed then move the current cell right one column
                when "d"
                    # puts "right"
                    if curr_col < @cols
                        clear_cell(curr_row, curr_col)  
                        curr_col += 1
                    end
                # if  the enter key is pressed then enter the formula editor
                when 10
                    # puts "enter"
                    formula_editor(curr_row, curr_col)
                    if @grid.get_cell(curr_row, curr_col) != nil
                        update_cursor(curr_row, curr_col, true)
                    end

                # if backspace is pressed then clear the cell and remove the cell from the grid
                when 8
                    clear_cell(curr_row, curr_col)
                    @grid.delete_cell(curr_row, curr_col)
                else 
                    puts input
            end
        end        
    end

    # Cursor updating function that visualizes the cursor in the grid
    # Shows cell coordinates or evaluated formula string if the cell is not empty
    def update_cursor(curr_row, curr_col, formula)
        @grid_window.attron(Curses::A_REVERSE)

        if curr_row == 0
            if curr_col == 0
                @grid_window.setpos(1, 1)
            else
                @grid_window.setpos(1, curr_col * 10 + 1)
            end
        else
            if curr_col == 0
                @grid_window.setpos(curr_row * 2 + 1, 1)
            else
                @grid_window.setpos(curr_row * 2 + 1, curr_col * 10 + 1)
            end
        end
        # if the cell is empty then print the cell coordinates
        if @grid.get_cell(curr_row, curr_col) == nil
            @grid_window.addstr("#{curr_row}, #{curr_col}")
        end
        # if the cell is not empty then print the evaluated formula string
        if formula
            # if evaluated formula string length is below 9 then print the formula string
            if @grid.get_cell(curr_row, curr_col).evaluate(@env).to_s.length < 8
                @grid_window.addstr(@grid.get_cell(curr_row, curr_col).evaluate(@env).to_s)
                # fill the rest of the cell with spaces
                @grid_window.addstr(" " * (9 - @grid.get_cell(curr_row, curr_col).evaluate(@env).to_s.length))
            else 
                @grid_window.addstr(@grid.get_cell(curr_row, curr_col).evaluate(@env).to_s[0..5])
                # add an ellipsis to the end of the string
                @grid_window.addstr("...")
            end
        end

        @grid_window.attroff(Curses::A_REVERSE)
    end

    def clear_cell(curr_row, curr_col)
        if @grid.get_cell(curr_row, curr_col) == nil

            if curr_row == 0
                if curr_col == 0
                    @grid_window.setpos(1, 1)
                else
                    @grid_window.setpos(1, curr_col * 10 + 1)
                end
            else
                if curr_col == 0
                    @grid_window.setpos(curr_row * 2 + 1, 1)
                else
                    @grid_window.setpos(curr_row * 2 + 1, curr_col * 10 + 1)
                end
            end
            @grid_window.addstr(" " * 9)    
        end
    end

    # Function for refreshing the display window with the current cell's evaluation
    def update_display(curr_row, curr_col)

        # set cursor position after the title and write grid coordinates
        @display_window.setpos(1, (Curses::cols / 2) - (@display_title.length / 2) + "Formula Editor".length)
        @display_window.addstr(" " * 8)
        @display_window.setpos(1, (Curses::cols / 2) - (@display_title.length / 2) + "Formula Editor".length)
        @display_window.addstr("[#{curr_row}, #{curr_col}]")

        # clear row 5-9 of the display window
        for i in 2..4
            @display_window.setpos(i, 2)
            @display_window.addstr(" " * ((Curses::cols) - 3))
        end

        if @grid.get_cell(curr_row, curr_col) == nil
            @display_window.setpos(3, (Curses::cols / 2) - ("EMPTY".length / 2))
            @display_window.addstr("EMPTY")
        else
            formula_answer = @grid.get_cell(curr_row, curr_col).evaluate(@env).to_s
            @display_window.setpos(3, (Curses::cols / 2) - (formula_answer.length / 2))
            @display_window.addstr(formula_answer)
        end
        @display_window.refresh
    end

    # Function for refreshing the formula window with the current cell's formula
    def update_formula(curr_row, curr_col)

        # set cursor position after the title and write grid coordinates
        @formula_window.setpos(1, (Curses::cols / 2) - (@display_title.length / 2) + "Formula Editor".length)
        @formula_window.addstr(" " * 8)
        @formula_window.setpos(1, (Curses::cols / 2) - (@display_title.length / 2) + "Formula Editor".length)
        @formula_window.addstr("[#{curr_row}, #{curr_col}]")

        # clear row 5-9 of the formula window
        for i in 2..4
            @formula_window.setpos(i, 2)
            @formula_window.addstr(" " * ((Curses::cols) - 3))
        end

        if @grid.get_cell(curr_row, curr_col) == nil
            @formula_window.setpos(3, (Curses::cols / 2) - ("NO FORMULA".length / 2))
            @formula_window.addstr("NO FORMULA")
        else
            @formula = @grid.get_cell(curr_row, curr_col).to_s
            @formula_window.setpos(3, (Curses::cols / 2) - (@formula.length / 2))
            @formula_window.addstr(@formula)
        end
        @formula_window.refresh
    end

    # Formula editing window logic. Contains an input loop for formula editing
    def formula_editor(curr_row, curr_col)

        # turn echoing back on for user input
        Curses::echo

        string_input = ""

        if @grid.get_cell(curr_row, curr_col) == nil
            # clear row 9 of the formula window
            @formula_window.setpos(3, 2)
            @formula_window.addstr(" " * (Curses::cols - 3))
            @formula_window.setpos(3, 2)
        else
            # move the formula to the left side of the formula window
            @formula_window.setpos(3, 2)
            @formula_window.addstr(" " * (Curses::cols - 3))
            @formula_window.setpos(3, 2)
            # print the formula in the formula window
            @formula_window.addstr(@user_formulas[[curr_row, curr_col]])
            string_input = @user_formulas[[curr_row, curr_col]]
            @formula_window.setpos(3, 2 + string_input.length)
        end
        
        new_formula = nil
        formula_expression = nil
        
        input = @formula_window.getch
        # loop until the user presses escape
        while true
            case input
            # pressing escape exits the formula editor imm
            when 27
                Curses::noecho
                return
            # if the user presses the enter key, 
            # evaluate the formula and store the result in the current cell
            # evaluation logic happens after the loop breaks
            when 10
                # puts "enter"
                # evaluate the formula
                # store the result in the current cell
                break
            when 8
                # puts "backspace"
                # delete the last character from the formula
                if string_input.length > 0
                    # delete the last character from the formula
                    string_input = string_input[0..-2]
                    # move the cursor back one space
                    @formula_window.setpos(3, 2 + string_input.length)
                    @formula_window.addstr(" ")
                    @formula_window.setpos(3, 2 + string_input.length)
                end
            # if the user presses any other key, add the character to the formula
            else
                @formula_window.setpos(3, 2)
                string_input += input.to_s
                @formula_window.addstr(string_input)
            end
            input = @formula_window.getch
        end

        if string_input[0] == "="
            @user_formulas[[curr_row, curr_col]] = string_input
            new_formula = string_input[1..-1]
            lexer = Lexer.new(new_formula, @env)
            lexer.lex(new_formula)
            # Check lexer validity and transform accordingly
            if lexer.validity == false
                invalid_formula = lexer.error + " | Full input: #{new_formula}"
                string_primitive = StringPrimitive.new(invalid_formula)
                @grid.set_cell(curr_row, curr_col, string_primitive)
            else     
                parsed = Parser.new(lexer.all_tokens, @env)
                parsed.parse
                # Check parser validity and transform accordingly
                if parsed.validity == false
                    invalid_formula = parsed.error + " | Full input: #{new_formula}"
                    string_primitive = StringPrimitive.new(invalid_formula)
                    @grid.set_cell(curr_row, curr_col, string_primitive)
                else
                    @grid.set_cell(curr_row, curr_col, parsed.ast)
                end
            end
        else
            @user_formulas[[curr_row, curr_col]] = string_input
            primitive = determine_primitive(string_input)
            @grid.set_cell(curr_row, curr_col, primitive)
        end
        Curses::noecho
    end

    # Function for determining the primitive type of the input
    # Classifies and returns a Primitive as defined in the model 
    def determine_primitive(input)

        primitive = nil

        if input == "true" || input == "false"
            primitive = BooleanPrimitive.new(input)
        # if float conversion is the same as the input, it is a float
        elsif input.to_f.to_s == input
            primitive = FloatPrimitive.new(input.to_f)
        # if integer conversion is the same as the input, it is an integer
        elsif input.to_i.to_s == input
            primitive = IntegerPrimitive.new(input.to_i)
        else
            primitive = StringPrimitive.new(input)
        end
        return primitive
    end
end

grid = Grid.new
env = Environment.new(grid)
Grapher.new(env).draw_interface

grid.to_s