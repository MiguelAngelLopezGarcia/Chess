require "./pieces/pieces.rb"

class Rook < Piece
    def put_rooks(grid)
      grid[0][0] = " ♜ "
      grid[0][7] = " ♜ "
      grid[7][0] = " ♖ "
      grid[7][7] = " ♖ "
    end
  end
  