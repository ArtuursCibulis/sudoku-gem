class Parser
    def self.parse(puzzle_string)
        Board.new(parse_to_array(puzzle_string))
    end

    def self.parse_to_array(puzzle_string)
        array = puzzle_string.lines
        array.select! { |x| x[0] != '-' }
        array.map! { |word| word.gsub( '|', '').strip.split(' ').map(&:to_i) }
    end
end
