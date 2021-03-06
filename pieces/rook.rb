require "./pieces/pieces.rb"
require "./pieces/movements.rb"

class Rook < Piece
  include Movements
  attr_accessor :possible_movements
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
    check_rook_move(grid, square, player)
  end

  def check_rook_move(grid, square, player)
    if player.color == "b"
      case
      when square[0] == 0 && square[1] == 0 && possible_movements.length > 0
        player.left_rook_moved = true
      when square[0] == 0 && square[1] == 7 && possible_movements.lenght > 0
        player.right_rook_moved = true
      else 
        return
      end
    elsif player.color == "w"
      case
      when square[0] == 7 && square[1] == 0 && possible_movements.lenght > 0
        player.left_rook_moved = true
      when square[0] == 7 && square[1] == 7 && possible_movements.lenght > 0
        player.right_rook_moved = true
      else 
        return
      end
    end
  end
end
  