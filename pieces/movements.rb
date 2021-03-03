require "./pieces/pieces.rb"

module Movements
  def find_possible_movement_pawn(grid, square, color)
    if color == "b"
      possible_square = square[0] + 1
      return if is_piece?(grid, [possible_square, square[1]])
      mark_square_and_push(grid, [possible_square, square[1]])
    elsif color == "w"
      possible_square = square[0] - 1
      return if is_piece?(grid, [possible_square, square[1]])
      mark_square_and_push(grid, [possible_square, square[1]])
    end
  end
    
  def find_possible_movement_initial_square_pawn(grid, square, color)
    possible_square = square[0]
    if color == "b"
      return if is_piece?(grid, [possible_square + 1, square[1]])
      2.times do
        possible_square += 1
        mark_square_and_push(grid, [possible_square, square[1]])
      end
    elsif color == "w"
      return if is_piece?(grid, [possible_square - 1, square[1]])
      2.times do
        possible_square -= 1
        mark_square_and_push(grid, [possible_square, square[1]])
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
          mark_piece_and_push(grid, [row, i])
          break
        end
      else
        mark_square_and_push(grid, [row, i])
        i -= 1
      end
    end
    while j <= 7
      if is_piece?(grid, [row, j])
        if is_same_color?(grid, square, [row, j])
          return
        else
          mark_piece_and_push(grid, [row, j])
          return
        end
      else
        mark_square_and_push(grid, [row, j])
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
          mark_piece_and_push(grid, [i, column])
          break
        end
      else
        mark_square_and_push(grid, [i, column])
        i -= 1
      end
    end
    while j <= 7
      if is_piece?(grid, [j, column])
        if is_same_color?(grid, square, [j, column])
          return
        else
          mark_piece_and_push(grid, [j, column])
          return
        end
      else
        mark_square_and_push(grid, [j, column])
        j += 1
      end
    end
  end

  def find_possible_movement_up_knight(grid, square)
    column = square[0] - 2
    row_left = square[1] -1
    row_right = square[1] + 1
    if is_piece?(grid, [column, row_left])
      unless is_same_color?(grid, square, [column, row_left])
        mark_piece_and_push(grid, [column, row_left]) if column >= 0 && row_left >= 0
      end
    else
      mark_square_and_push(grid, [column, row_left]) if column >= 0 && row_left >= 0
    end
    if is_piece?(grid, [column, row_right])
      unless is_same_color?(grid, square, [column, row_right])
        mark_piece_and_push(grid, [column, row_right]) if column >= 0 && row_right <= 7
      end
    else
      mark_square_and_push(grid, [column, row_right]) if column >= 0 && row_right <= 7
    end
  end

  def find_possible_movement_down_knight(grid, square)
    column = square[0] + 2
    row_left = square[1] -1
    row_right = square[1] + 1
    if is_piece?(grid, [column, row_left])
      unless is_same_color?(grid, square, [column, row_left])
        mark_piece_and_push(grid, [column, row_left]) if column <= 7 && row_left >= 0
      end
    else
      mark_square_and_push(grid, [column, row_left]) if column <= 7 && row_left >= 0
    end
    if is_piece?(grid, [column, row_right])
      unless is_same_color?(grid, square, [column, row_right])
        mark_piece_and_push(grid, [column, row_right]) if column <= 7 && row_right <= 7
      end
    else
      mark_square_and_push(grid, [column, row_right]) if column <= 7 && row_right <= 7
    end
  end

  def find_possible_movement_left_knight(grid, square)
    column_up = square[0] - 1
    column_down = square[0] + 1
    row = square[1] - 2
    if is_piece?(grid, [column_up, row])
      unless is_same_color?(grid, square, [column_down, row])
        mark_piece_and_push(grid, [column_down, row]) if column_down <= 7 && row >= 0
      end
    else
      mark_square_and_push(grid, [column_down, row]) if column_down <= 7 && row >= 0
    end
    if is_piece?(grid, [column_up, row])
      unless is_same_color?(grid, square, [column_up, row])
        mark_piece_and_push(grid, [column_up, row]) if column_up >= 0 && row >= 0
      end
    else
      mark_square_and_push(grid, [column_up, row]) if column_up >= 0 && row >= 0
    end
  end

  def find_possible_movement_right_knight(grid, square)
    column_up = square[0] - 1
    column_down = square[0] + 1
    row = square[1] + 2
    if is_piece?(grid, [column_down, row])
      unless is_same_color?(grid, square, [column_down, row])
        mark_piece_and_push(grid, [column_down, row]) if column_down <= 7 && row <= 7
      end
    else
      mark_square_and_push(grid, [column_down, row]) if column_down <= 7 && row <= 7
    end
    if is_piece?(grid, [column_up, row])
      unless is_same_color?(grid, square, [column_up, row])
        mark_piece_and_push(grid, [column_up, row]) if column_up >= 0 && row <= 7
      end
    else
      mark_square_and_push(grid, [column_up, row]) if column_up >= 0 && row <= 7
    end
  end

  def find_possible_movement_left_up(grid, square)
    column = square[0] - 1
    row = square[1] - 1
    until column < 0 || row < 0
      mark_square_and_push(grid, [column, row])
      column -= 1
      row -= 1
    end
  end
     
  def find_possible_movement_left_down(grid, square)
    column = square[0] + 1
    row = square[1] - 1
    until column > 7 || row < 0
      mark_square_and_push(grid, [column, row])
      column += 1
      row -= 1
    end
  end
    
  def find_possible_movement_right_up(grid, square)
    column = square[0] - 1
    row = square[1] + 1
    until column < 0 || row > 7
      mark_square_and_push(grid, [column, row])
      column -= 1
      row += 1
    end
  end
    
  def find_possible_movement_right_down(grid, square)
    column = square[0] + 1
    row = square[1] + 1
    until column > 7 || row > 7
      mark_square_and_push(grid, [column, row])
      column += 1
      row += 1
    end
  end
    
  def move_one_column(grid, square)
    column = square[0] - 1
    mark_square_and_push(grid, [column, square[1]]) if column >= 0
    column += 2
    mark_square_and_push(grid, [column, square[1]]) if column <= 7
  end

  def move_one_row(grid, square)
    row = square[1] -1
    mark_square_and_push(grid, [square[0], row]) if row >= 0
    row += 2
    mark_square_and_push(grid, [square[0], row]) if row <= 7
  end

  def move_one_left_diagonal(grid, square)
    column = square[0] - 1
    row = square[1] - 1
    mark_square_and_push(grid, [column, row]) if column >= 0 && row >= 0
    column += 2
    row += 2
    mark_square_and_push(grid, [column, row]) if column <= 7 && row <= 7
  end

  def move_one_right_diagonal(grid, square)
    column = square[0] - 1
    row = square[1] + 1
    mark_square_and_push(grid, [column, row]) if column >= 0 && row <= 7
    column += 2
    row -= 2
    mark_square_and_push(grid, [column, row]) if column <= 7 && row >= 0
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