require "./lib/pieces/pieces.rb"
require "./lib/pieces/movements.rb"


class Knight < Piece
  include Movements
  attr_accessor :possible_movements, :grid
  def initialize
    @possible_movements = []
  end

  def put_knights(grid)
    grid[0][1] = " ♞ ".colorize(:color => :blue)
    grid[0][6] = " ♞ ".colorize(:color => :blue)
    grid[7][1] = " ♘ "
    grid[7][6] = " ♘ "
  end

  def select_piece(grid, square, player)
    find_possible_movement_up_knight(grid, square)
    find_possible_movement_down_knight(grid, square)
    find_possible_movement_left_knight(grid, square)
    find_possible_movement_right_knight(grid, square)
    validate_my_movements(grid, possible_movements, square, player)
    possible_movements.map {|this_square| mark_possible_movement(grid, this_square)}
    color_this_square(grid, square)
    @grid = grid
  end

  def is_in_check_pre_movement?(grid, square, player)
    knight = isolate_my_piece(grid, square)
    knight_color = recognice_piece_color(knight)
    find_possible_movement_up_knight(grid, square)
    find_possible_movement_down_knight(grid, square)
    find_possible_movement_left_knight(grid, square)
    find_possible_movement_right_knight(grid, square)
    possible_movements.map do |this_square|
      piece = isolate_my_piece(grid, this_square)
      if piece == "♚" && player.color == "b" && knight_color == "w"
        return true
      elsif piece == "♔" && player.color == "w" && knight_color == "b"
        return true
      end
    end
    return false
  end

end
  