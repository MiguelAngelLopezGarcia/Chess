require "./pieces/pieces.rb"


class Knight < Piece
    def put_knights(grid)
      grid[0][1] = " ♞ "
      grid[0][6] = " ♞ "
      grid[7][1] = " ♘ "
      grid[7][6] = " ♘ "
    end
  end
  