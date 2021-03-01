require "./pieces/pieces.rb"

class Bishop < Piece
  attr_accessor :possible_movements
  def put_bishops(grid)
    grid[0][2] = " ♝ "
    grid[0][5] = " ♝ "
    grid[7][2] = " ♗ "
    grid[7][5] = " ♗ "
  end

  def select_piece(grid, square)
    @possible_movements = []
    find_possible_movement_left_up(grid, square)
    find_possible_movement_left_down(grid, square)
    find_possible_movement_right_up(grid, square)
    find_possible_movement_right_down(grid, square)
  end

  def find_possible_movement_left_up(grid, square)
    column = square[0] - 1
    row = square[1] - 1
    until column < 0 || row < 0
      possible_movements.push([column, row])
      mark_possible_movement(grid, [column, row])
      column -= 1
      row -= 1
    end
  end
 
  def find_possible_movement_left_down(grid, square)
    column = square[0] + 1
    row = square[1] - 1
    until column > 7 || row < 0
      possible_movements.push([column, row])
      mark_possible_movement(grid, [column, row])
      column += 1
      row -= 1
    end
  end

  def find_possible_movement_right_up(grid, square)
    column = square[0] - 1
    row = square[1] + 1
    until column < 0 || row > 7
      possible_movements.push([column, row])
      mark_possible_movement(grid, [column, row])
      column -= 1
      row += 1
    end
  end

  def find_possible_movement_right_down(grid, square)
    column = square[0] + 1
    row = square[1] + 1
    until column > 7 || row > 7
      possible_movements.push([column, row])
      mark_possible_movement(grid, [column, row])
      column += 1
      row += 1
    end
  end
end
  