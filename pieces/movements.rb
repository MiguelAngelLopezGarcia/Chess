require "./pieces/pieces.rb"

module Movements
  def find_possible_movement_pawn(grid, square, color)
    if color == "b"
      possible_square = square[0] + 1
      return if is_piece?(grid, [possible_square, square[1]])
      possible_movements.push([possible_square, square[1]])
      mark_possible_movement(grid, [possible_square, square[1]])
    elsif color == "w"
      possible_square = square[0] - 1
      return if is_piece?(grid, [possible_square, square[1]])
      possible_movements.push([possible_square, square[1]])
      mark_possible_movement(grid, [possible_square, square[1]])
    end
  end
    
  def find_possible_movement_initial_square_pawn(grid, square, color)
    possible_square = square[0]
    if color == "b"
      return if is_piece?(grid, [possible_square + 1, square[1]])
      2.times do
        possible_square += 1
        possible_movements.push([possible_square, square[1]])
        mark_possible_movement(grid, [possible_square, square[1]])
      end
    elsif color == "w"
      return if is_piece?(grid, [possible_square - 1, square[1]])
      2.times do
        possible_square -= 1
        possible_movements.push([possible_square, square[1]])
        mark_possible_movement(grid, [possible_square, square[1]])
      end
    end
  end

  def find_possible_movement_row(grid, square)
    row = square[0]
    i = square[1] - 1
    j = square[1] + 1
    while i >= 0
      if is_piece?(grid, [row, i])
        if is_same_color?(grid, square, [row, i])
          break
        else
          mark_atacked_piece(grid, [row, i])
          possible_movements.push([row, i])
          break
        end
      else
        possible_movements.push([row, i])
        mark_possible_movement(grid, [row, i])
        i -= 1
      end
    end
    while j <= 7
      if is_piece?(grid, [row, j])
        if is_same_color?(grid, square, [row, j])
          return
        else
          mark_atacked_piece(grid, [row, j])
          possible_movements.push([row, j])
          return
        end
      else
        possible_movements.push([row, j])
        mark_possible_movement(grid, [row, j])
        j += 1
      end
    end
  end
  
    
  def find_possible_movement_column(grid, square)
    column = square[1]
    i = square[0] - 1
    j = square[0] + 1
    while i >= 0
      if is_piece?(grid, [i, column])
        if is_same_color?(grid, square, [i, column])
          break
        else
          possible_movements.push([i, column])
          mark_atacked_piece(grid, [i, column])
          break
        end
      else
        possible_movements.push([i, column])
        mark_possible_movement(grid, [i, column])
        i -= 1
      end
    end
    while j <= 7
      if is_piece?(grid, [j, column])
        if is_same_color?(grid, square, [j, column])
          return
        else
          mark_atacked_piece(grid, [j, column])
          possible_movements.push([j, column])
          return
        end
      else
        possible_movements.push([j, column])
        mark_possible_movement(grid, [j, column])
        j += 1
      end
    end
  end

  def find_possible_movement_up_knight(grid, square)
    column = square[0] - 2
    row_left = square[1] -1
    row_right = square[1] + 1
    possible_movements.push([column, row_left]) if column >= 0 && row_left >= 0
    mark_possible_movement(grid, [column, row_left]) if column >= 0 && row_left >= 0
    possible_movements.push([column, row_right]) if column >= 0 && row_right <= 7
    mark_possible_movement(grid, [column, row_right]) if column >= 0 && row_right <= 7
  end

  def find_possible_movement_down_knight(grid, square)
    column = square[0] + 2
    row_left = square[1] -1
    row_right = square[1] + 1
    possible_movements.push([column, row_left]) if column <= 7 && row_left >= 0
    mark_possible_movement(grid, [column, row_left]) if column <= 7 && row_left >= 0
    possible_movements.push([column, row_right]) if column <= 7 && row_right <= 7
    mark_possible_movement(grid, [column, row_right]) if column <= 7 && row_right <= 7
  end

  def find_possible_movement_left_knight(grid, square)
    column_up = square[0] - 1
    column_down = square[0] + 1
    row = square[1] - 2
    possible_movements.push([column_down, row]) if column_down <= 7 && row >= 0
    mark_possible_movement(grid, [column_down, row]) if column_down <= 7 && row >= 0
    possible_movements.push([column_up, row]) if column_up >= 0 && row >= 0
    mark_possible_movement(grid, [column_up, row]) if column_up >= 0 && row >= 0
  end

  def find_possible_movement_right_knight(grid, square)
    column_up = square[0] - 1
    column_down = square[0] + 1
    row = square[1] + 2
    possible_movements.push([column_down, row]) if column_down <= 7 && row <= 7
    mark_possible_movement(grid, [column_down, row]) if column_down <= 7 && row <= 7
    possible_movements.push([column_up, row]) if column_up >= 0 && row <= 7
    mark_possible_movement(grid, [column_up, row]) if column_up >= 0 && row <= 7
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
    
  def move_one_column(grid, square)
    column = square[0] - 1
    possible_movements.push([column, square[1]]) if column >= 0
    mark_possible_movement(grid, [column, square[1]]) if column >= 0
    column += 2
    possible_movements.push([column, square[1]]) if column <= 7
    mark_possible_movement(grid, [column, square[1]]) if column <= 7
  end

  def move_one_row(grid, square)
    row = square[1] -1
    possible_movements.push([square[0], row]) if row >= 0
    mark_possible_movement(grid, [square[0], row]) if row >= 0
    row += 2
    possible_movements.push([square[0], row]) if row <= 7
    mark_possible_movement(grid, [square[0], row]) if row <= 7
  end

  def move_one_left_diagonal(grid, square)
    column = square[0] - 1
    row = square[1] - 1
    possible_movements.push([column, row]) if column >= 0 && row >= 0
    mark_possible_movement(grid, [column, row]) if column >= 0 && row >= 0
    column += 2
    row += 2
    possible_movements.push([column, row]) if column <= 7 && row <= 7
    mark_possible_movement(grid, [column, row]) if column <= 7 && row <= 7
  end

  def move_one_right_diagonal(grid, square)
    column = square[0] - 1
    row = square[1] + 1
    possible_movements.push([column, row]) if column >= 0 && row <= 7
    mark_possible_movement(grid, [column, row]) if column >= 0 && row <= 7
    column += 2
    row -= 2
    possible_movements.push([column, row]) if column <= 7 && row >= 0
    mark_possible_movement(grid, [column, row]) if column <= 7 && row >= 0
  end

  def move_to(grid, square_from, square_to)
    piece = grid[square_from[0]][square_from[1]].split(" ")
    piece = piece[1]    
    delete_moved_piece(grid, square_from)
    move_piece(grid, square_to, piece)
    i = 0
    until i == possible_movements.length
      unmark_possible_movement(grid, possible_movements[i])
      i += 1
    end
  end
  
end