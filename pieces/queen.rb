require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Queen < Piece
  include Movements
  attr_accessor :possible_movements
  def put_queens(grid)
    grid[0][3] = " ♛ "
    grid[7][3] = " ♕ "
  end

  def select_piece(grid, square)
    @possible_movements = []
    find_possible_movement_row(grid, square)
    find_possible_movement_column(grid, square)
    find_possible_movement_left_up(grid, square)
    find_possible_movement_left_down(grid, square)
    find_possible_movement_right_up(grid, square)
    find_possible_movement_right_down(grid, square)
  end
end
  