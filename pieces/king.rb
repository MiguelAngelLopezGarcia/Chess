require "./pieces/pieces.rb"
require "./pieces/movements.rb"
require "./players.rb"

class King < Piece
  include Movements
  attr_accessor :possible_movements
  def initialize
    @possible_movements = []
  end

  def put_kings(grid)
    grid[0][4] = " ♚ "
    grid[7][4] = " ♔ "
  end

  def select_piece(grid, square, player)
    move_one_column(grid, square)
    move_one_row(grid, square)
    move_one_left_diagonal(grid, square)
    move_one_right_diagonal(grid, square)
    is_in_check(grid, possible_movements, square, player)
    mark_castle(player.color, grid, square, possible_movements, player) if player.is_possible_to_castle?
    is_in_check(grid, possible_movements, square, player)
    possible_movements.map {|this_square| mark_possible_movement(grid, this_square)}
    player.king_moved = true if player.is_possible_to_castle? == true && possible_movements.length > 0
    color_this_square(grid, square)
  end

  def mark_castle(color, grid, square, array, player)
    case
    when color == "b"
      if array.include?([0, 3]) && player.left_rook_moved == false && !is_piece?(grid, [0, 1]) && !is_piece?(grid, [0, 2])
        possible_movements.push([0, 2])
      end
      if array.include?([0, 5]) && player.right_rook_moved == false && !is_piece?(grid, [0, 6])
        possible_movements.push([0, 6])
      end
    when color == "w"
      if array.include?([7, 3]) && player.left_rook_moved == false && !is_piece?(grid, [7, 1]) && !is_piece?(grid, [7, 2])
        possible_movements.push([7, 2])
      end
      if array.include?([7, 5]) && player.right_rook_moved == false && !is_piece?(grid, [7, 6])
        possible_movements.push([7, 6])
      end 
    end
  end

  def check_moving_castle(grid, square_from, square_to)
    if square_from[0] == 0 && square_from[1] == 4
      case 
      when square_to[1] == 2
        delete_moved_piece(grid, [0, 0])
        grid[0][3] = " ♜ "
      when square_to[1] == 6
        delete_moved_piece(grid, [0, 7])
        grid[0][5] =  " ♜ "
      else 
        return
      end
    elsif square_from[0] == 7 && square_from[1] == 4
      case 
      when square_to[1] == 2
        delete_moved_piece(grid, [7, 0])
        grid[7][3] = " ♖ "
      when square_to[1] == 6
        delete_moved_piece(grid, [7, 7])
        grid[7][5] = " ♖ "
      else 
        return
      end
    end
  end

  def is_in_check_pre_movement?(grid, square, player)
    king = grid[square[0]][square[1]].split(" ")
    king_color = recognice_piece_color(king[1])
    move_one_column(grid, square)
    move_one_row(grid, square)
    move_one_left_diagonal(grid, square)
    move_one_right_diagonal(grid, square)
    possible_movements.map do |this_square|
      piece = grid[this_square[0]][this_square[1]].split(" ")
      piece = piece[1]
      if piece == "♚" && player.color == "b" && king_color == "w"
        return true
      elsif piece == "♔" && player.color == "w" && king_color == "b"
        return true
      end
    end
    return false
  end
end