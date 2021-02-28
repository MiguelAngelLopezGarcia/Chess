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

  def select_piece(grid, square)
    @possible_movements = []
    piece = grid[square[0]][square[1]]
    piece = piece.split(" ")
    piece = piece[1]
    if square[0] == 1 || square[0] == 6
      find_possible_movement_initial_square(grid, square, recognice_piece_color(piece))
    else
      find_possible_movement(grid, square, recognice_piece_color(piece))
    end
    return grid
  end

  def find_possible_movement(grid, square, color)
    if color == "b"
      possible_square = square[0] + 1
      possible_movements.push([possible_square, square[1]])
      mark_possible_movement(grid, [possible_square, square[1]])
    elsif color == "w"
      possible_square = square[0] - 1
      possible_movements.push([possible_square, square[1]])
      mark_possible_movement(grid, [possible_square, square[1]])
    end
  end

  def find_possible_movement_initial_square(grid, square, color)
    possible_square = square[0]
    if color == "b"
      2.times do
        possible_square += 1
        possible_movements.push([possible_square, square[1]])
        mark_possible_movement(grid, [possible_square, square[1]])
      end
    elsif color == "w"
      2.times do
        possible_square -= 1
        possible_movements.push([possible_square, square[1]])
        mark_possible_movement(grid, [possible_square, square[1]])
      end
    end
  end
end
  