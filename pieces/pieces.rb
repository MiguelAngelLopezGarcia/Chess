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

  def move_piece(grid, square, piece)
    piece_to_move = grid[square[0]][square[1]].split(" ")
    piece_to_move[1] = piece
    piece_to_move = piece_to_move.join(" ")
    grid[square[0]][square[1]] = piece_to_move
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:color => :default)
  end

  def delete_moved_piece(grid, square)
    piece_to_delete = grid[square[0]][square[1]].split(" ")
    piece_to_delete[1] = " "
    piece_to_delete = piece_to_delete.join(" ")
    grid[square[0]][square[1]] = piece_to_delete
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:color => :default)
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
    piece_to_delete = grid[square[0]][square[1]].split(" ")
    piece_to_delete[1] = " "
    piece_to_delete = piece_to_delete.join(" ")
    grid[square[0]][square[1]] = piece_to_delete
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:color => :default)
  end
  
  def mark_atacked_piece(grid, square)
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:background => :red)
  end
end
