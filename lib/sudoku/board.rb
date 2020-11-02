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
                return false if element != item.array[x][y]
            end
        end
        true
    end

    def columns
        array.transpose
    end
    
    def filled?
        array.none? { |a| a.include?(0) }
    end

    def valid?
        Validator.new(self).valid?
    end

    def subgroups
        @subgroups ||= array.each_slice(3).map{|stripe| stripe.transpose.each_slice(3).map{|chunk| chunk.transpose}}.flatten(1)
    end

    def to_s
        array.map { |word| word.join(' ') }
        .map { |word| word.insert(6, "|") }
        .map { |word| word.insert(13, "|") }
        .insert(3, "------+------+------" )
        .insert(7, "------+------+------" )
        .join("\n")
        .concat("\n")
    end

    def insert(x, y, val)
        perform_validation do
            (1..9).include?(val)
            masiivs = to_a
            masiivs[x][y] = val
            masiivs
        end
    end

    def insert!(x, y, val)
        perform_validation(x, y, val) do
            array[x][y].value = val
            array
        end
    end

    private def perform_validation(x, y, val)
        if array[x][y].locked
            raise PermissionDeniedError.new("Šo vērtību nevar izmainīt")
        elsif (1..9).include?(val)
            yield
        else
            raise PermissionDeniedError.new("Kļūda! Ievadīt var tikai 1-9")
        end
    end

    def [](index)
        array[index].map(&:value)
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
            row.map(&:value)
        end
    end
end

class PermissionDeniedError < StandardError
end
