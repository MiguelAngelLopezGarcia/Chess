require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class King < Pieces
  include Movements
  attr_accessor :possible_movements
  def put_kings(grid)
    grid[0][4] = " ♚ "
    grid[7][4] = " ♔ "
  end
end