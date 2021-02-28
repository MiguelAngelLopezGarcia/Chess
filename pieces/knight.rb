require "./pieces/pieces.rb"


class Knight < Piece
  attr_accessor :possible_movements
  def put_knights(grid)
    grid[0][1] = " ♞ "
    grid[0][6] = " ♞ "
    grid[7][1] = " ♘ "
    grid[7][6] = " ♘ "
  end

  def select_piece(grid, square)
    @possible_movements = []
    find_possible_movement_up(grid, square)
    find_possible_movement_down(grid, square)
    find_possible_movement_left(grid, square)
    find_possible_movement_right(grid, square)
  end

  def find_possible_movement_up(grid, square)
    column = square[0] - 2
    row_left = square[1] -1
    row_right = square[1] + 1
    possible_movements.push([column, row_left]) if column >= 0 && row_left >= 0
    mark_possible_movement(grid, [column, row_left]) if column >= 0 && row_left >= 0
    possible_movements.push([column, row_right]) if column >= 0 && row_right <= 7
    mark_possible_movement(grid, [column, row_right]) if column >= 0 && row_right <= 7
  end

  def find_possible_movement_down(grid, square)
    column = square[0] + 2
    row_left = square[1] -1
    row_right = square[1] + 1
    possible_movements.push([column, row_left]) if column <= 7 && row_left >= 0
    mark_possible_movement(grid, [column, row_left]) if column <= 7 && row_left >= 0
    possible_movements.push([column, row_right]) if column <= 7 && row_right <= 7
    mark_possible_movement(grid, [column, row_right]) if column <= 7 && row_right <= 7
  end

  def find_possible_movement_left(grid, square)
    column_up = square[0] - 1
    column_down = square[0] + 1
    row = square[1] - 2
    possible_movements.push([column_down, row]) if column_down <= 7 && row >= 0
    mark_possible_movement(grid, [column_down, row]) if column_down <= 7 && row >= 0
    possible_movements.push([column_up, row]) if column_up >= 0 && row >= 0
    mark_possible_movement(grid, [column_up, row]) if column_up >= 0 && row >= 0
  end

  def find_possible_movement_right(grid, square)
    column_up = square[0] - 1
    column_down = square[0] + 1
    row = square[1] + 2
    possible_movements.push([column_down, row]) if column_down <= 7 && row <= 7
    mark_possible_movement(grid, [column_down, row]) if column_down <= 7 && row <= 7
    possible_movements.push([column_up, row]) if column_up >= 0 && row <= 7
    mark_possible_movement(grid, [column_up, row]) if column_up >= 0 && row <= 7
  end
end
  