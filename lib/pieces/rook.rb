require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Rook < Piece
  include Movements
  attr_accessor :possible_movements, :grid
  def initialize
    @possible_movements = []
  end

  def put_rooks(grid)
    grid[0][0] = " ♜ "
    grid[0][7] = " ♜ "
    grid[7][0] = " ♖ "
    grid[7][7] = " ♖ "
  end

  def select_piece(grid, square, player)
    @possible_movements = []
    find_possible_movement_row(grid, square)
    find_possible_movement_column(grid, square)
    is_in_check(grid, possible_movements, square, player)
    possible_movements.map {|this_square| mark_possible_movement(grid, this_square)}
    color_this_square(grid, square)
    @grid = grid
  end

  def check_rook_move(grid, square, player)
    if player.color == "b"
      case
      when square[0] == 0 && square[1] == 0
        player.left_rook_moved = true
      when square[0] == 0 && square[1] == 7
        player.right_rook_moved = true
      else 
        return
      end
    elsif player.color == "w"
      case
      when square[0] == 7 && square[1] == 0 
        player.left_rook_moved = true
      when square[0] == 7 && square[1] == 7 
        player.right_rook_moved = true
      else 
        return
      end
    end
  end

  def is_in_check_pre_movement?(grid, square, player)
    rook = grid[square[0]][square[1]].split(" ")
    rook_color = recognice_piece_color(rook[1])
    find_possible_movement_row(grid, square)
    find_possible_movement_column(grid, square)
    possible_movements.map do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "b" && rook_color == "w"
        return true
      elsif piece == "♔" && player.color == "w" && rook_color == "b"
        return true
      end
    end
    return false
  end

  def is_in_check_post_movement?(grid, square, player)
    rook = grid[square[0]][square[1]].split(" ")
    rook_color = recognice_piece_color(rook[1])
    find_possible_movement_row(grid, square)
    find_possible_movement_column(grid, square)
    possible_movements.map do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "w" && rook_color == "w"
        return true
      elsif piece == "♔" && player.color == "b" && rook_color == "b"
        return true
      end
    end
    return false
  end


end
  