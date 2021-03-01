require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Bishop < Piece
  include Movements
  attr_accessor :possible_movements
  def put_bishops(grid)
    grid[0][2] = " ♝ "
    grid[0][5] = " ♝ "
    grid[7][2] = " ♗ "
    grid[7][5] = " ♗ "
  end

  def select_piece(grid, square)
    @possible_movements = []
    find_possible_movement_left_up(grid, square)
    find_possible_movement_left_down(grid, square)
    find_possible_movement_right_up(grid, square)
    find_possible_movement_right_down(grid, square)
  end

end
  