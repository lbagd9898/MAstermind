# Module includes method for checking each codebreaker's guess and returning corresponding clues
module CheckGuess  


    def check_guess(guess, code)
        red_points = 0
        white_points = 0
        incorrect_placement_guesses = []
        incorrect_placement_code = []
        index = 0 
        4.times do 
            if code[index] == guess[index]
                red_points += 1
            else
                incorrect_placement_guesses.push(guess[index])
                incorrect_placement_code.push(code[index])
            end
            index += 1
        end 
        incorrect_placement_guesses.each do |i|
            if incorrect_placement_code.include? i 
                incorrect_placement_code.delete_at(incorrect_placement_code.index(i))
                white_points += 1
            end
        end
        points = [red_points, white_points]
    end

end