require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class King < Piece
  include Movements
  attr_accessor :possible_movements
  def put_kings(grid)
    grid[0][4] = " ♚ "
    grid[7][4] = " ♔ "
  end

  def select_piece(grid, square)
    @possible_movements = []
    move_one_column(grid, square)
    move_one_row(grid, square)
    move_one_left_diagonal(grid, square)
    move_one_right_diagonal(grid, square)
  end
end