#Clases para cada pieza
#Tal vez la reina puede ser combinación de alfil y torre
#Tal vez rey igual pero con la limitación de 1 casilla

class Piece
  def recognice_piece(piece)
    pawn = ["♟", "♙"]
    rook = ["♜", "♖"]
    knight = ["♞", "♘"]
    bishop = ["♝", "♗"]
    queen = ["♛", "♕"]
    king = ["♚", "♔"]
    if pawn.include? piece
      return "p"
    elsif rook.include? piece
      return "r"
    elsif knight.include? piece
      return "k"
    elsif bishop.include? piece
      return "b"
    elsif queen.include? piece
      return "q"
    elsif king.include? piece
      return "k"
    end
  end
  
  def recognice_piece_color (piece)
    black = ["♟", "♜", "♞", "♝", "♛", "♚"]
    white = ["♙", "♖", "♘", "♗", "♕", "♔"]
    if black.include? piece
      return "b"
    elsif white.include? piece
      return "w"
    end
  end

  def move_piece(square, piece)
    square = piece
    square
  end

  def delete_moved_piece(square)
    square = "   "
    
    square
  end

  def mark_possible_movement(grid, square)
    possible_movement = grid[square[0]][square[1]].split(" ")
    possible_movement.push("")
    possible_movement[2] = possible_movement[1]
    possible_movement[1] = "●"
    possible_movement = possible_movement.join(" ")
    grid[square[0]][square[1]] = possible_movement.colorize(:red)
    grid
  end

  def unmark_possible_movement(grid, square)
    square = "   "
    square.colorize(:default)
    square
  end
  
  def mark_atacked_piece(grid, square)
    square.colorize(:background => red)
    square
  end
end

class Pawn < Piece
  def put_pawns(grid)
    grid[1].map! do |piece|
      piece = " ♟ "
    end
    grid[6].map! do |piece|
      piece = " ♙ "
    end
  end

  def move(grid, square)
    piece = grid[square[0]][square[1]]
    piece = piece.split(" ")
    piece = piece[1]
    if recognice_piece_color(piece) == "b"
      if square[0] == 1
        possible_movement_initial_square(grid, square, "b")
      else
        possible_movement(grid, square, "b")
      end
    elsif recognice_piece_color(piece) == "w"
      if square[0] == 6
        possible_movement_initial_square(grid, square, "w")
      else
        possible_movement(grid, square, "w")
      end    
    end
  end

  def possible_movement(grid, square, color)
    if color == "b"
      square[0] += 1
      mark_possible_movement(grid, square)
    elsif color == "w"
      square[0] -= 1
      mark_possible_movement(grid, square)
    end
  end

  def possible_movement_initial_square(grid, square, color)
    if color == "b"
      i = 0
      until i == 2
        square [0] += 1
        mark_possible_movement(grid, square)
        i += 1
      end
    elsif color == "w"
      i = 0
      until i == 2
        square [0] -= 1
        mark_possible_movement(grid, square)
        i += 1
      end
    end
  end
end

class Rook < Piece
  def put_rooks(grid)
    grid[0][0] = " ♜ "
    grid[0][7] = " ♜ "
    grid[7][0] = " ♖ "
    grid[7][7] = " ♖ "
  end
end

class Knight < Piece
  def put_knights(grid)
    grid[0][1] = " ♞ "
    grid[0][6] = " ♞ "
    grid[7][1] = " ♘ "
    grid[7][6] = " ♘ "
  end
end

class Bishop < Piece
  def put_bishops(grid)
    grid[0][2] = " ♝ "
    grid[0][5] = " ♝ "
    grid[7][2] = " ♗ "
    grid[7][5] = " ♗ "
  end
end

class Queen < Piece
  def put_queens(grid)
    grid[0][3] = " ♛ "
    grid[7][3] = " ♕ "
  end
end

class King < Queen
  def put_kings(grid)
    grid[0][4] = " ♚ "
    grid[7][4] = " ♔ "
  end
end