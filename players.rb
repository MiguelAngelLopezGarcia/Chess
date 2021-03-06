class Player
    attr_accessor :color, :king_moved, :left_rook_moved, :right_rook_moved
    def initialize(color)
        @color = color
        @king_moved = false
        @left_rook_moved = false
        @right_rook_moved = false
    end

    def is_possible_to_castle?
        return true if king_moved == false && left_rook_moved == false && right_rook_moved == false
        false
    end
end