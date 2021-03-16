require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Bishop < Piece
  include Movements
  attr_accessor :possible_movements, :grid
  def initialize
    @possible_movements = []
  end

  def put_bishops(grid)
    grid[0][2] = " ♝ "
    grid[0][5] = " ♝ "
    grid[7][2] = " ♗ "
    grid[7][5] = " ♗ "
  end

  def select_piece(grid, square, player)
    find_possible_movement_left_up(grid, square)
    find_possible_movement_left_down(grid, square)
    find_possible_movement_right_up(grid, square)
    find_possible_movement_right_down(grid, square)
    is_in_check(grid, possible_movements, square, player)
    possible_movements.map {|this_square| mark_possible_movement(grid, this_square)}
    color_this_square(grid, square)
    @grid = grid
  end

  def is_in_check_pre_movement?(grid, square, player)
    bishop = grid[square[0]][square[1]].split(" ")
    bishop_color = recognice_piece_color(bishop[1])
    find_possible_movement_left_up(grid, square)
    find_possible_movement_left_down(grid, square)
    find_possible_movement_right_up(grid, square)
    find_possible_movement_right_down(grid, square)
    possible_movements.map do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "b" && bishop_color == "w"
        return true
      elsif piece == "♔" && player.color == "w" && bishop_color == "b"
        return true
      end
    end
    return false
  end

  def is_in_check_post_movement?(grid, square, player)
    bishop = grid[square[0]][square[1]].split(" ")
    bishop_color = recognice_piece_color(bishop[1])
    find_possible_movement_left_up(grid, square)
    find_possible_movement_left_down(grid, square)
    find_possible_movement_right_up(grid, square)
    find_possible_movement_right_down(grid, square)
    possible_movements.map do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "w" && bishop_color == "w"
        return true
      elsif piece == "♔" && player.color == "b" && bishop_color == "b"
        return true
      end
    end
    return false
  end

end
  