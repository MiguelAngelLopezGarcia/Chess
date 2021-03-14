require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Pawn < Piece
  include Movements
  attr_accessor :possible_movements
  def initialize
    @possible_movements = []
  end

  def put_pawns(grid)
    grid[1].map! do |piece|
      piece = " ♟ "
    end
    grid[6].map! do |piece|
      piece = " ♙ "
    end
  end

  def select_piece(grid, square, player)
    piece = grid[square[0]][square[1]]
    piece = piece.split(" ")
    piece = piece[1]
    if square[0] == 1 && recognice_piece_color(piece) == "b" || square[0] == 6 && recognice_piece_color(piece) == "w"
      find_possible_movement_initial_square_pawn(grid, square, recognice_piece_color(piece))
    else
      find_possible_movement_pawn(grid, square, recognice_piece_color(piece))
    end
    find_possible_attack_pawn(grid, square, recognice_piece_color(piece))
    is_in_check(grid, possible_movements, square, player)
    possible_movements.map {|this_square| mark_possible_movement(grid, this_square)}
  end

  def check_pawn_promotion(grid, square, color)
    if color == "b"
      if square[0] == 7
        new_piece = grid[square[0]][square[1]].split(" ")
        new_piece[1] = "♛"
        new_piece = new_piece.join(" ")
        grid[square[0]][square[1]] = new_piece
      end
    elsif color == "w"
      if square[0] == 0
        new_piece = grid[square[0]][square[1]].split(" ")
        new_piece[1] = "♕"
        new_piece = new_piece.join(" ")
        grid[square[0]][square[1]] = new_piece
      end
    end
  end

  def is_in_check_pre_movement?(grid, square, player)
    pawn = grid[square[0]][square[1]].split(" ") 
    pawn_color = recognice_piece_color(pawn[1])
    find_possible_attack_pawn(grid, square, pawn_color)
    possible_movements.each do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "b" && pawn_color == "w"
        return true
      elsif piece == "♔" && player.color == "w" && pawn_color == "b"
        return true
      end
    end
    return false
  end

end
  