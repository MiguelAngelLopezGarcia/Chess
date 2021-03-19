require "./lib/pieces/pieces.rb"
require "./lib/pieces/movements.rb"

class Queen < Piece
  include Movements
  attr_accessor :possible_movements, :grid
  def initialize
    @possible_movements = []
  end

  def put_queens(grid)
    grid[0][3] = " ♛ ".colorize(:color => :blue)
    grid[7][3] = " ♕ "
  end

  def select_piece(grid, square, player)
    find_possible_movement_row(grid, square)
    find_possible_movement_column(grid, square)
    find_possible_movement_left_up(grid, square)
    find_possible_movement_left_down(grid, square)
    find_possible_movement_right_up(grid, square)
    find_possible_movement_right_down(grid, square)
    validate_my_movements(grid, possible_movements, square, player)
    possible_movements.map {|this_square| mark_possible_movement(grid, this_square)}
    color_this_square(grid, square)
    @grid = grid
  end

  def is_in_check_pre_movement?(grid, square, player)
    queen = isolate_my_piece(grid, square)
    queen_color = recognice_piece_color(queen)
    find_possible_movement_row(grid, square)
    find_possible_movement_column(grid, square)
    find_possible_movement_left_up(grid, square)
    find_possible_movement_left_down(grid, square)
    find_possible_movement_right_up(grid, square)
    find_possible_movement_right_down(grid, square)
    possible_movements.map do |this_square|
      piece = isolate_my_piece(grid, this_square)
      if piece == "♚" && player.color == "b" && queen_color == "w"
        return true
      elsif piece == "♔" && player.color == "w" && queen_color == "b"
        return true
      end
    end
    return false
  end

end
  