class Player
    attr_accessor :color, :color_english, :color_spanish, :king_moved, :left_rook_moved, :right_rook_moved, :possible_squares, :pieces_availables, :previous_move, :turn
    def initialize(color, color_english, color_spanish)
        @color = color
        @color_english = color_english
        @color_spanish = color_spanish
        @king_moved = false
        @left_rook_moved = false
        @right_rook_moved = false
        @possible_squares = []
        @pieces_availables = []
        @previous_move = []
        @turn = 1
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