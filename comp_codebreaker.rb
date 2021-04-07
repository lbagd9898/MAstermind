require_relative 'check_guesses.rb'
# take out when linking doc
NUMBERS = [1, 2, 3, 4, 5, 6]
POSSIBLE_CLUES = [[0, 4], [0, 3], [0, 2], [0, 1], [0, 0], [1, 0], [2, 0], [3, 0],
[1, 1], [1, 2], [1, 3], [2, 1], [2, 2]]

class ComputerBreaker
    include CheckGuess

    attr_reader :s, :t

    def initialize
        @s = make_s
        @t = make_s
            
    end 

    def make_s
        s = []
        NUMBERS.each do |x|
            NUMBERS.each do |y|
                NUMBERS.each do |z|
                    NUMBERS.each do |a|
                        int = [x, y, z, a]
                        s.push(int)
                    end
                end
            end
        end
        s
    end
    

    def remove_invalid_codes(guess, clue)
        @s.delete_if do |s|
            check_guess(guess, s) != clue
        end 
        p @s
        puts @s.length
    end 

    def minimax 
        @t.each do |t|
            clue_scores = []
            POSSIBLE_CLUES.each do |c|
                score = 0
                @s.each do |s|
                    if check_guess(t, s) != c
                        score += 1
                    end 
                end
                clue_scores.push(score)
            end
        end 
    end 





    
    
end 

computer = ComputerBreaker.new()
computer.remove_invalid_codes([1, 1, 2, 2], [0, 3])
