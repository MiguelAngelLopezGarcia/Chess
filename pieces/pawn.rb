require "./pieces/pieces.rb"

class Pawn < Piece
  attr_accessor :possible_movements
  def put_pawns(grid)
    grid[1].map! do |piece|
      piece = " ♟ "
    end
    grid[6].map! do |piece|
      piece = " ♙ "
    end
  end

  def move(grid, square)
    @possible_movements = []
    piece = grid[square[0]][square[1]]
    piece = piece.split(" ")
    piece = piece[1]
    if square[0] == 1 || square[0] == 6
      possible_movement_initial_square(grid, square, recognice_piece_color(piece))
    else
      possible_movement(grid, square, recognice_piece_color(piece))
    end
    return grid
  end

  def possible_movement(grid, square, color)
    if color == "b"
      square[0] += 1
      possible_movements.push(square)
      mark_possible_movement(grid, square)
    elsif color == "w"
      square[0] -= 1
      possible_movements.push(square)
      mark_possible_movement(grid, square)
    end
  end

  def possible_movement_initial_square(grid, square, color)
    if color == "b"
      2.times do
        square_to_mark = []
        square[0] += 1
        square_to_mark[0] = square[0]
        square_to_mark[1] = square[1]
        possible_movements.push(square_to_mark)
        mark_possible_movement(grid, square)
      end
    elsif color == "w"
      2.times do
        square_to_mark = []
        square[0] -= 1
        square_to_mark[0] = square[0]
        square_to_mark[1] = square[1]
        possible_movements.push(square_to_mark)
        mark_possible_movement(grid, square)
      end
    end
  end

  def move_to(grid, square_from, square_to)
    piece = grid[square_from[0]][square_from[1]].split(" ")
    piece = piece[1]    
    delete_moved_piece(grid, square_from)
    move_piece(grid, square_to, piece)
    i = 0
    until i == possible_movements.length
      unmark_possible_movement(grid, possible_movements[i])
      i += 1
    end
  end

end
  