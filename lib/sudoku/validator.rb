class Validator
    def initialize(board)
        @board = board
    end

    def valid?
        unique_numbers?(@board.columns) && 
            unique_numbers?(@board.array) &&
            unique_numbers?(@board.subgroups.map(&:flatten))
    end

    private

    def unique_numbers?(group_array)
        group_array.map { |items| items.reject(&:zero?) }.all? do |items|
            items.uniq.length == items.length
        end
    end
end
