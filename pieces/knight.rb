require "./pieces/pieces.rb"
require "./pieces/movements.rb"


class Knight < Piece
  include Movements
  attr_accessor :possible_movements
  def put_knights(grid)
    grid[0][1] = " ♞ "
    grid[0][6] = " ♞ "
    grid[7][1] = " ♘ "
    grid[7][6] = " ♘ "
  end

  def select_piece(grid, square)
    @possible_movements = []
    find_possible_movement_up_knight(grid, square)
    find_possible_movement_down_knight(grid, square)
    find_possible_movement_left_knight(grid, square)
    find_possible_movement_right_knight(grid, square)
  end

end
  