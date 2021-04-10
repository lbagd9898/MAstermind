require_relative "make_s.rb"

#Module includes all methods for giving game instructions, taking in parameters to initialize Game class, and board display elements
module DisplayBoard
    include MakeS

    def give_directions
        puts "Mastermind: Rules of Play".bold.colorize(:green)
        puts ''
        puts "2 Players 1 Secret Code".bold.colorize(:green)
        puts "Mastermind involves 2 players: 1 Mastermind and 1 Codebreaker."
        puts "The Mastermind creates a 4-digit secret code consisting any of" 
        puts "the following 6 number blocks:"
        puts ''
        puts display_colored_guess(NUMBERS)
        puts ''
        puts "For example, a " + "secret code".red + " could look like this:"
        puts ''
        puts display_colored_guess([1, 5, 4, 5])
        puts ""
        puts "Guesses and Clues".bold.colorize(:green)
        puts "The Codebreaker gets 12 turns to guess the Mastermind's secret code."
        puts "Each turn, the Codebreaker makes a guess as to what"
        puts "they think the code is. After each turn, the Mastermind"
        puts "gives the Codebreaker a clue consisting of red and white points."
        puts ""
        puts "For each correct number block the Codebreaker guesses"
        puts "in the correct place, the Mastermind will give the"
        puts "Codebreaker a red point: " + display_colored_points([1, 0])
        puts ""
        puts "For each correct number block the Codebreaker guesses"
        puts "in the incorrect place, the Mastermind will give the"
        print "Codebreaker a white point: "
        puts display_colored_points([0, 1])
        puts ""
        puts "Turn Example".bold.colorize(:green)
        puts "Using the " + "secret code".red + " given above, if the Codebreaker"
        puts "submitted a guess of 1356, the console output would be:"
        puts ""
        puts display_colored_guess([1, 3, 5, 6]) + " Clues: " + display_colored_points([1, 1])
        puts ""
        puts "meaning that the Codebreaker guessed 1 correct number block in the"
        puts "correct place (1) and 1 correct number block in the incorrect place (5)."
        puts ''
        puts "Let's play!".bold.colorize(:green)
    end

    def start_game? 
        valid_input = ["1", "2"]
        loop do
            puts "Press 1 to be the Mastermind. Press 2 to be the Codebreaker."
            input = gets.chomp
            if valid_input.include? input
                return input
            else 
                puts "Please enter either 1 or 2.".red
            end
         end 
    end

    def choose_code 
        s = make_s
        loop do 
            puts "Pick a 4-digit secret code consisting of any numbers 1-6.".green
            input = gets.chomp
            input = input.chars.map(&:to_i)
            if s.include? input
                return input
            else 
                puts "Invalid Code.".red
            end
        end
    end

    def display_colored_guess(guess)
        string = ''
        guess.each do |n| 
            string += "  #{n}  ".colorize(background: COLORS[n-1])
        end 
        string
    end

    def display_colored_points(points)
        string = ''
        red_points = points[0]
        white_points = points[1]
        red_points.times do 
            string += "* ".red.bold
        end
        white_points.times do
            string += "* ".white.bold
        end
        string
    end

end 