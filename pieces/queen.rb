require "./pieces/pieces.rb"

class Queen < Piece
  def put_queens(grid)
    grid[0][3] = " ♛ "
    grid[7][3] = " ♕ "
  end
end
  