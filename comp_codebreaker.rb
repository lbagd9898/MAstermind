require_relative 'check_guesses.rb'
# take out when linking doc
POSSIBLE_CLUES = [[0, 4], [0, 3], [0, 2], [0, 1], [0, 0], [1, 0], [2, 0], [3, 0],
[1, 1], [1, 2], [1, 3], [2, 1], [2, 2]]


#Class initialized for Computer codebreaker only. Includes all methods to implement Knuth's codebreaking strategy.
class ComputerBreaker
    include CheckGuess

    attr_reader :s, :t

    def initialize
        @s = make_s
        @t = make_s
        @turn = 1
        @guesses = []
            
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
    

    def make_guess(clues) 
        puts "Round #{@turn}. Computer's Turn!"
        last_clue = clues.last()
        if @turn == 1
            guess = [1, 1, 2, 2]
        else 
            last_guess = @guesses.last()
            remove_invalid_codes(last_guess, last_clue)
            guess = minimax()
        end
        @guesses.append(guess)
        @turn += 1
        guess
    end 



    
    def remove_invalid_codes(guess, clue)
        @s.delete_if do |s|
            check_guess(guess, s) != clue
        end 
        @t.delete(guess)
    end 

    def minimax 
        scores = {}
        @t.each do |t|
            clue_scores = []
            POSSIBLE_CLUES.each do |c|
                non_hits = 0
                @s.each do |s|
                    if check_guess(t, s) != c
                        non_hits += 1
                    end 
                end
                clue_scores.push(non_hits)
            end
            min = clue_scores.min
            scores[t] = min
        end 
        max = scores.values.max
        max_scores = scores.select { |k, v| v == max }
        max_scores = max_scores.map { |x, v| x}
        scores_in_s = max_scores.select{ |x| @s.include? x}
        if scores_in_s.length == 0
            score = max_scores[0]
        else 
            score = scores_in_s[0]
        end 
        score


    end 

    
    
end 

