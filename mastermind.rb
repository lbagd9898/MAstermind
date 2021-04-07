require 'colorize'
require_relative 'displayboard.rb'
require_relative 'check_guesses.rb'

include DisplayBoard

NUMBERS = [1, 2, 3, 4, 5, 6]

COLORS = [:red, :yellow, :green, :blue, :light_blue, :magenta]

class Game
    include DisplayBoard

    def initialize()
        @mastermind = MasterMind.new(0)
        @codebreaker = CodeBreaker.new()
    end

    def play
        12.times do 
            points = game_round 
            p points
            if points[0] == 4
                puts "You Won!"
                return 
            end
        end
        puts "You didn't crack the code!"
    end

    def game_round
        guess = @codebreaker.make_guess
        guess_display = DisplayBoard.display_colored_guess(guess)
        points = @mastermind.check_guess(guess, @mastermind.code_array)
        points_display = DisplayBoard.display_colored_points(points)
        puts "#{guess_display} Clue: #{points_display}"
        points 
    end 
    
end 


class MasterMind
    include CheckGuess

    attr_reader :code_array
   
    def initialize(code_array)
        if code_array == 0
            create_code()
        else 
            @code_array = code_array
        end
        p @code_array
        
    end

    def create_code 
        @code_array = []
        4.times do 
            number = NUMBERS.sample
            @code_array.append(number)
        end
        @code_array
    end



    # def check_guess(guess)
    #     red_points = 0
    #     white_points = 0
    #     incorrect_placement_guesses = []
    #     incorrect_placement_code = []
    #     index = 0 
    #     4.times do 
    #         if @code_array[index] == guess[index]
    #             red_points += 1
    #         else
    #             incorrect_placement_guesses.push(guess[index])
    #             incorrect_placement_code.push(@code_array[index])
    #         end
    #         index += 1
    #     end 
    #     # p red_points
    #     # p incorrect_placement_guesses
    #     incorrect_placement_guesses.each do |i|
    #         if incorrect_placement_code.include? i 
    #             incorrect_placement_code.delete_at(incorrect_placement_code.index(i))
    #             white_points += 1
    #         end
    #         # p incorrect_placement_code
    #     end
    #     points = [red_points, white_points]
    # end

end

class CodeBreaker
    
    def initialize()
        @guesses = []
    end

    def make_guess
        loop do 
            puts "Type in four numbers (1-6) to guess MasterMind's code."
            guess = gets.chomp.to_i
            guess_array = guess.to_s.chars.map(&:to_i)

            if guess_array.length != 4
                puts "Please enter 4 numbers (1-6).".red
            elsif !(guess_array.all?{ |i| NUMBERS.include? i })
                puts "Please enter 4 numbers (1-6).".red
            else 
                return guess_array 
            end
        end    
    end


end 

game = Game.new()
game.play
# mastermind = MasterMind.new([1, 2, 3])






