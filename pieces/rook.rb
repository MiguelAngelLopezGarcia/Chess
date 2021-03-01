require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Rook < Piece
  include Movements
  attr_accessor :possible_movements
  def put_rooks(grid)
    grid[0][0] = " ♜ "
    grid[0][7] = " ♜ "
    grid[7][0] = " ♖ "
    grid[7][7] = " ♖ "
  end

  def select_piece(grid, square)
    @possible_movements = []
    find_possible_movement_row(grid, square)
    find_possible_movement_column(grid, square)
  end
    
end
  