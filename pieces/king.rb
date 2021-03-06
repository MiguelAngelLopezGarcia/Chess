require "./pieces/pieces.rb"
require "./pieces/movements.rb"
require "./players.rb"

class King < Piece
  include Movements
  attr_accessor :possible_movements
  def put_kings(grid)
    grid[0][4] = " ♚ "
    grid[7][4] = " ♔ "
  end

  def select_piece(grid, square, player)
    @possible_movements = []
    move_one_column(grid, square)
    move_one_row(grid, square)
    move_one_left_diagonal(grid, square)
    move_one_right_diagonal(grid, square)
    mark_castle(player.color, grid, square) if player.is_possible_to_castle?
    player.king_moved = true if possible_movements.lenght > 0
  end

  def mark_castle(color, grid, square)
    case
    when color == "b"
      if !is_piece?(grid, [0, 1]) && !is_piece?(grid, [0, 2]) && !is_piece?(grid, [0, 3])
        mark_square_and_push(grid, [0, 2])
      end
      if !is_piece?(grid, [0, 5]) && !is_piece?(grid, [0, 6])
        mark_square_and_push(grid, [0, 6])
      end
    when color == "w"
      if !is_piece?(grid, [7, 1]) && !is_piece?(grid, [7, 2]) && !is_piece?(grid, [7, 3])
        mark_square_and_push(grid, [7, 2])
      end
      if !is_piece?(grid, [7, 5]) && !is_piece?(grid, [7, 6])
        mark_square_and_push(grid, [7, 6])
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
end