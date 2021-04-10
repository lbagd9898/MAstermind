require 'colorize'
require_relative 'displayboard.rb'
require_relative 'check_guesses.rb'
require_relative 'comp_codebreaker.rb'

include DisplayBoard

NUMBERS = [1, 2, 3, 4, 5, 6]

COLORS = [:red, :yellow, :green, :blue, :light_blue, :magenta]


Game class. Keeps track of all game parts. Initialized every for every 12-turn round.
class Game
    include DisplayBoard

    def initialize(mastermind, codebreaker, comp_codebreaker)
        @comp_codebreaker = comp_codebreaker
        @mastermind = mastermind
        @codebreaker = codebreaker
        @clues = []
    end

    def play
        12.times do 
            points = game_round 
            if points[0] == 4
                if @comp_codebreaker == true
                    puts "The Computer Won!"
                else 
                    puts "You Won!"
                end
                return 
            end
        end
        puts "You didn't crack the code!"
    end

    def game_round
        guess = @codebreaker.make_guess(@clues)
        guess_display = DisplayBoard.display_colored_guess(guess)
        points = @mastermind.check_guess(guess, @mastermind.code_array)
        @clues.push(points)
        points_display = DisplayBoard.display_colored_points(points)
        puts ""
        puts "#{guess_display} Clue: #{points_display}"
        puts ""
        points 
    end 
    
end 

# Mastermind class - keep track of secret code and checking Codebreaker's guesses
class MasterMind
    include CheckGuess

    attr_reader :code_array
   
    def initialize(code_array)
        if code_array == 0
            create_code()
        else 
            @code_array = code_array
        end
        
    end

    def create_code 
        @code_array = []
        4.times do 
            number = NUMBERS.sample
            @code_array.append(number)
        end
        @code_array
    end


end


# Class initialized for human Codebreaker only. Takes in user guess input
class CodeBreaker
    
    def initialize()
        @round = 1
    end

    def make_guess(clues)
        loop do 
            puts "Round #{@round}. Type in four numbers (1-6) to guess Mastermind's code."
            guess = gets.chomp.to_i
            guess_array = guess.to_s.chars.map(&:to_i)

            if guess_array.length != 4
                puts "Please enter 4 numbers (1-6).".red
            elsif !(guess_array.all?{ |i| NUMBERS.include? i })
                puts "Please enter 4 numbers (1-6).".red
            else 
                @round += 1
                return guess_array 
            end
        end  
    end


end 

    DisplayBoard.give_directions
    loop do 
        input = DisplayBoard.start_game?
        if input == "1" 
            code = DisplayBoard.choose_code
            mastermind = MasterMind.new(code)
            codebreaker = ComputerBreaker.new()
            comp_codebreaker = true 
        elsif input == "2"
            mastermind = MasterMind.new(0)
            codebreaker = CodeBreaker.new()  
            comp_codebreaker = false
            puts "You are the Codebreaker. The Mastermind will now choose a code.".green
            sleep 2
        end 
        game = Game.new(mastermind, codebreaker, comp_codebreaker)
        game.play
        puts "Press 1 to play again. Press any other key to quit.".green
        answer = gets.chomp 
        if answer != "1"
            puts "See you later!".green
            return
        end
        puts "Let's play again!".green
        puts ""
    end






