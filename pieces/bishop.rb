require "./pieces/pieces.rb"

class Bishop < Piece
  def put_bishops(grid)
    grid[0][2] = " ♝ "
    grid[0][5] = " ♝ "
    grid[7][2] = " ♗ "
    grid[7][5] = " ♗ "
  end
end
  