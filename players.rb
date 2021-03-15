class Player
    attr_accessor :color, :full_color, :king_moved, :left_rook_moved, :right_rook_moved, :possible_squares
    def initialize(color, full_color)
        @color = color
        @full_color = full_color
        @king_moved = false
        @left_rook_moved = false
        @right_rook_moved = false
        @possible_squares = []
    end

    def is_possible_to_castle?
        if king_moved == false
            if left_rook_moved == false || right_rook_moved == false
                return true
            end
        end
        return false
    end

end