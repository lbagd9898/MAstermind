
#Module include function to generate s, the set of all possible mastermind codes
module MakeS

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

end