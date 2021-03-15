require "./pieces/pieces.rb"
require "./pieces/movements.rb"


class Knight < Piece
  include Movements
  attr_accessor :possible_movements
  def initialize
    @possible_movements = []
  end

  def put_knights(grid)
    grid[0][1] = " ♞ "
    grid[0][6] = " ♞ "
    grid[7][1] = " ♘ "
    grid[7][6] = " ♘ "
  end

  def select_piece(grid, square, player)
    find_possible_movement_up_knight(grid, square)
    find_possible_movement_down_knight(grid, square)
    find_possible_movement_left_knight(grid, square)
    find_possible_movement_right_knight(grid, square)
    is_in_check(grid, possible_movements, square, player)
    possible_movements.map {|this_square| mark_possible_movement(grid, this_square)}
    color_this_square(grid, square)
  end

  def is_in_check_pre_movement?(grid, square, player)
    knight = grid[square[0]][square[1]].split(" ")
    knight_color = recognice_piece_color(knight[1])
    find_possible_movement_up_knight(grid, square)
    find_possible_movement_down_knight(grid, square)
    find_possible_movement_left_knight(grid, square)
    find_possible_movement_right_knight(grid, square)
    possible_movements.map do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "b" && knight_color == "w"
        return true
      elsif piece == "♔" && player.color == "w" && knight_color == "b"
        return true
      end
    end
    return false
  end

  def is_in_check_post_movement?(grid, square, player)
    knight = grid[square[0]][square[1]].split(" ")
    knight_color = recognice_piece_color(knight[1])
    find_possible_movement_up_knight(grid, square)
    find_possible_movement_down_knight(grid, square)
    find_possible_movement_left_knight(grid, square)
    find_possible_movement_right_knight(grid, square)
    possible_movements.map do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "w" && knight_color == "w"
        return true
      elsif piece == "♔" && player.color == "b" && knight_color == "b"
        return true
      end
    end
    return false
  end

end
  