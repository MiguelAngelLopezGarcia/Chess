require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Pawn < Piece
  include Movements
  attr_accessor :possible_movements, :square_en_passant, :grid
  def initialize
    @possible_movements = []
    @square_en_passant = []
  end

  def put_pawns(grid)
    grid[1].map! do |piece|
      piece = " ♟ "
    end
    grid[6].map! do |piece|
      piece = " ♙ "
    end
  end

  def select_piece(grid, square, player, other_player)
    piece = grid[square[0]][square[1]]
    piece = piece.split(" ")
    piece = piece[1]
    piece_color = recognice_piece_color(piece)
    if square[0] == 1 && piece_color == "b" || square[0] == 6 && piece_color == "w"
      find_possible_movement_initial_square_pawn(grid, square, piece_color)
    else
      find_possible_movement_pawn(grid, square, piece_color)
    end
    find_possible_attack_pawn(grid, square, piece_color)
    find_en_passant(grid, square, piece_color, other_player) if square[0] == 3 && piece_color == "w" || square[0] == 4 && piece_color == "b"
    is_in_check(grid, possible_movements, square, player)
    possible_movements.map {|this_square| mark_possible_movement(grid, this_square)}
    if square_en_passant.empty? == false && player.color == "b"
      mark_possible_movement(grid, [square_en_passant[0][0] - 1, square_en_passant[0][1]])
    elsif square_en_passant.empty? == false && player.color == "w"
      mark_possible_movement(grid, [square_en_passant[0][0] + 1, square_en_passant[0][1]])
    end
    color_this_square(grid, square)
    @grid = grid
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

  def is_in_check_post_movement?(grid, square, player)
    pawn = grid[square[0]][square[1]].split(" ") 
    pawn_color = recognice_piece_color(pawn[1])
    find_possible_attack_pawn(grid, square, pawn_color)
    possible_movements.each do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "w" && pawn_color == "w"
        return true
      elsif piece == "♔" && player.color == "b" && pawn_color == "b"
        return true
      end
    end
    return false
  end

  def move_to(grid, square_from, square_to, is_for_check=false)
    piece = grid[square_from[0]][square_from[1]].split(" ")
    piece = piece[1]
    piece_color = recognice_piece_color(piece)
    delete_moved_piece(grid, square_from)
    move_piece(grid, square_to, piece)
    if is_for_check == false 
      i = 0
      until i == possible_movements.length
        unmark_possible_movement(grid, possible_movements[i])
        i += 1
      end
    end
    check_pawn_promotion(grid, square_to, recognice_piece_color(piece))
    if square_to == square_en_passant[0]
      if piece_color == "b"
        delete_moved_piece(grid, [square_to[0] - 1, square_to[1]])
      else
        delete_moved_piece(grid, [square_to[0] + 1, square_to[1]])
      end
    end
  end

end
  