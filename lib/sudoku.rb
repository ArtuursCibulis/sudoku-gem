class Board
    attr_reader :array

    def initialize(array)
        @array = array.map do |row|
            row.map { |element| CellValue.new(element, !element.zero?)}
        end 
    end

    def ==(item)
        array.each_with_index do |row, x| 
            row.each_with_index do |element, y|
                if element != item.array[x][y]
                    return false
                end
            end
        end
        true
    end

    def columns
        column_array = array.transpose
    end
    
    def filled?
        array.none? { |a| a.include?(0) }
    end

    def valid?
        Validator.new(self).valid?
    end

    def subgroups
        array.each_slice(3).map{|stripe| stripe.transpose.each_slice(3).map{|chunk| chunk.transpose}}.flatten(1)
    end

    def to_s
        array.map! { |word| word.join(' ') }
        array.map! { |word| word.insert(6, "|") }
        array.map! { |word| word.insert(13, "|") }
        array.map! { |word| word.insert(-1, "\n") }
        array1 = array.insert(3, "------+------+------\n" )
        array2 = array.insert(7, "------+------+------\n" )
    end

    def insert(x, y, val)
        if array[x][y].locked
            raise PermissionDeniedError.new("Šo vērtību nevar izmainīt")
        elsif (1..9).include?(val)
            masiivs = to_a
            masiivs[x][y] = val
            masiivs
        else
            raise PermissionDeniedError.new("Kļūda! Ievadīt var tikai 1-9")
        end
    end

    def insert!(x, y, val)
        if array[x][y].locked
            raise PermissionDeniedError.new("Šo vērtību nevar izmainīt")
        elsif (1..9).include?(val)
            array[x][y].value = val
            array
        else
            raise PermissionDeniedError.new("Kļūda! Ievadīt var tikai 1-9")
        end
    end

    CellValue = Struct.new(:value, :locked) do
        def ==(num)
            value == num
        end

        def zero?
            value.zero?
        end

        def to_s
            value.to_s
        end

    end

    def to_a
        array.map do |row|
            row.map { |element| element.value }
        end
    end

end

class Validator
    def initialize(board)
        @board = board
    end

    def valid?
        unique_column_numbers? && unique_row_numbers? && unique_sub_area_numbers? 
    end

    def unique_column_numbers?
        @board.columns.map { |column| column.reject(&:zero?) }.all? do |column|
          column.uniq.length == column.length
        end
    end

    def unique_row_numbers?
        @board.array.map { |row| row.reject(&:zero?) }.all? do |row|
          row.uniq.length == row.length
        end
    end

    def unique_sub_area_numbers?
        @board.subgroups.all? do |items|
          items.uniq.length == items.length
        end
    end
end

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

class PermissionDeniedError < StandardError
end