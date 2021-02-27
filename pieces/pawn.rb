require "./pieces/pieces.rb"

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

  def move_to(grid, square, square_to)
    piece = grid[square[0]][square[1]].split(" ")
    piece = piece[1]    
    grid = delete_moved_piece(grid, square)
    grid = move_piece(grid, square_to, piece)
  end

end
  