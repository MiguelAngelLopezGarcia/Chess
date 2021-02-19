#Clases para cada pieza
#Tal vez la reina puede ser combinación de alfil y torre
#Tal vez rey igual pero con la limitación de 1 casilla





class Pawn
  def put_pawns(grid)
    grid[1].map! do |piece|
      piece = " ♟ "
    end
    grid[6].map! do |piece|
      piece = " ♙ "
    end
  end
end

class Rook
  def put_rooks(grid)
    grid[0][0] = " ♜ "
    grid[0][7] = " ♜ "
    grid[7][0] = " ♖ "
    grid[7][7] = " ♖ "
  end
end

class Knight
  def put_knights(grid)
    grid[0][1] = " ♞ "
    grid[0][6] = " ♞ "
    grid[7][1] = " ♘ "
    grid[7][6] = " ♘ "
  end
end

class Bishop
  def put_bishops(grid)
    grid[0][2] = " ♝ "
    grid[0][5] = " ♝ "
    grid[7][2] = " ♗ "
    grid[7][5] = " ♗ "
  end
end

class Queen
  def put_queens(grid)
    grid[0][3] = " ♛ "
    grid[7][3] = " ♕ "
  end
end

class King
  def put_kings(grid)
    grid[0][4] = " ♚ "
    grid[7][4] = " ♔ "
  end
end