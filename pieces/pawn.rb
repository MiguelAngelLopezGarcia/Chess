require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Pawn < Piece
  include Movements
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
    if square[0] == 1 && recognice_piece_color(piece) == "b" || square[0] == 6 && recognice_piece_color(piece) == "w"
      find_possible_movement_initial_square_pawn(grid, square, recognice_piece_color(piece))
    else
      find_possible_movement_pawn(grid, square, recognice_piece_color(piece))
    end
    find_possible_attack_pawn(grid, square, recognice_piece_color(piece))
  end
end
  