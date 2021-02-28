require "./pieces/queen.rb"

class King < Queen
  def put_kings(grid)
    grid[0][4] = " ♚ "
    grid[7][4] = " ♔ "
  end
end