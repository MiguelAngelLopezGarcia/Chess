require "./pieces/pieces.rb"

module Movements
  def find_possible_movement_pawn(grid, square, color)
    if color == "b"
      possible_square = square[0] + 1
      return if is_piece?(grid, [possible_square, square[1]])
      possible_movements.push([possible_square, square[1]])
    elsif color == "w"
      possible_square = square[0] - 1
      return if is_piece?(grid, [possible_square, square[1]])
      possible_movements.push([possible_square, square[1]])
    end
  end
    
  def find_possible_movement_initial_square_pawn(grid, square, color)
    possible_square = square[0]
    if color == "b"
      2.times do
        possible_square += 1
        return if is_piece?(grid, [possible_square, square[1]])
        possible_movements.push([possible_square, square[1]])
      end
    elsif color == "w"
      2.times do
        possible_square -= 1
        return if is_piece?(grid, [possible_square, square[1]])
        possible_movements.push([possible_square, square[1]])
      end
    end
  end

  def find_possible_attack_pawn(grid, square, color)
    left = square[1] - 1
    right = square[1] + 1
    if color == "b"
      column = square[0] + 1
      if left >= 0 && is_piece?(grid, [column, left])
        unless is_same_color?(grid, square, [column, left])
          possible_movements.push([column, left])
        end
      end
      if right <= 7 && is_piece?(grid, [column, right])
        unless is_same_color?(grid, square, [column, right])
          possible_movements.push([column, right])
        end
      end
    end
    if color == "w"
      column = square[0] - 1
      if left >= 0 && is_piece?(grid, [column, left])
        unless is_same_color?(grid, square, [column, left])
          possible_movements.push([column, left])
        end
      end
      if right <= 7 && is_piece?(grid, [column, right])
        unless is_same_color?(grid, square, [column, right])
          possible_movements.push([column, right])
        end
      end
    end
  end

  def find_en_passant(grid, square, color, other_player)
    square_from_other_player = other_player.previous_move[0]
    square_to_other_player = other_player.previous_move[1]
    other_player_piece = grid[square_to_other_player[0]][square_to_other_player[1]].split(" ")
    other_player_piece = other_player_piece[1]
    row_moved_for_white = square_to_other_player[0] - square_from_other_player[0]
    row_moved_for_black = square_from_other_player[0] - square_to_other_player[0]
    column_of_my_pawn = square[1]
    column_of_other_player = square_to_other_player[1]
    if other_player.color == "b" && square_from_other_player[0] == 1 && other_player_piece == "♟" && row_moved_for_white == 2
      case 
      when column_of_my_pawn - column_of_other_player == 1
        possible_movements.push([square[0] - 1, square[1] - 1])
        square_en_passant.push([square[0] - 1, square[1] - 1])
      when column_of_other_player - column_of_my_pawn == 1
        possible_movements.push([square[0] - 1, square[1] + 1])
        square_en_passant.push([square[0] - 1, square[1] + 1])
      end
    elsif other_player.color == "w" && square_from_other_player[0] == 6 && other_player_piece == "♙" && row_moved_for_black == 2
      case 
      when column_of_my_pawn - column_of_other_player == 1
        possible_movements.push([square[0] + 1, square[1] - 1])
        square_en_passant.push([square[0] + 1, square[1] - 1])
      when column_of_other_player - column_of_my_pawn == 1
        possible_movements.push([square[0] + 1, square[1] + 1])
        square_en_passant.push([square[0] + 1, square[1] + 1])
      end
    end
  end

  def find_possible_movement_row(grid, square) #For rook and queen
    row = square[0]
    i = square[1] - 1
    j = square[1] + 1
    while i >= 0
      if is_piece?(grid, [row, i])
        if is_same_color?(grid, square, [row, i])
          break
        else
          possible_movements.push([row, i])
          break
        end
      else
        possible_movements.push([row, i])
        i -= 1
      end
    end
    while j <= 7
      if is_piece?(grid, [row, j])
        if is_same_color?(grid, square, [row, j])
          return
        else
          possible_movements.push([row, j])
          return
        end
      else
        possible_movements.push([row, j])
        j += 1
      end
    end
  end
  
    
  def find_possible_movement_column(grid, square) #For rook and queen
    column = square[1]
    i = square[0] - 1
    j = square[0] + 1
    while i >= 0
      if is_piece?(grid, [i, column])
        if is_same_color?(grid, square, [i, column])
          break
        else
          possible_movements.push([i, column])
          break
        end
      else
        possible_movements.push([i, column])
        i -= 1
      end
    end
    while j <= 7
      if is_piece?(grid, [j, column])
        if is_same_color?(grid, square, [j, column])
          return
        else
          possible_movements.push([j, column])
          return
        end
      else
        possible_movements.push([j, column])
        j += 1
      end
    end
  end

  def find_possible_movement_up_knight(grid, square)
    column = square[0] - 2
    row_left = square[1] -1
    row_right = square[1] + 1
    if column >= 0 && row_left >= 0 && is_piece?(grid, [column, row_left])
      unless is_same_color?(grid, square, [column, row_left])
        possible_movements.push([column, row_left])
      end
    elsif column >= 0 && row_left >= 0
      possible_movements.push([column, row_left])
    end
    if column >= 0 && row_right <= 7 && is_piece?(grid, [column, row_right])
      unless is_same_color?(grid, square, [column, row_right])
        possible_movements.push([column, row_right])
      end
    elsif column >= 0 && row_right <= 7
      possible_movements.push([column, row_right]) 
    end
  end

  def find_possible_movement_down_knight(grid, square)
    column = square[0] + 2
    row_left = square[1] -1
    row_right = square[1] + 1
    if column <= 7 && row_left >= 0 && is_piece?(grid, [column, row_left])
      unless is_same_color?(grid, square, [column, row_left])
        possible_movements.push([column, row_left]) 
      end
    elsif column <= 7 && row_left >= 0
      possible_movements.push([column, row_left])
    end
    if column <= 7 && row_right <= 7 && is_piece?(grid, [column, row_right])
      unless is_same_color?(grid, square, [column, row_right])
        possible_movements.push([column, row_right])
      end
    elsif column <= 7 && row_right <= 7
      possible_movements.push([column, row_right])
    end
  end

  def find_possible_movement_left_knight(grid, square)
    column_up = square[0] - 1
    column_down = square[0] + 1
    row = square[1] - 2
    if column_down <= 7 && row >= 0 && is_piece?(grid, [column_up, row])
      unless is_same_color?(grid, square, [column_down, row])
        possible_movements.push([column_down, row])  
      end
    elsif column_down <= 7 && row >= 0
      possible_movements.push([column_down, row])
    end
    if column_up >= 0 && row >= 0 && is_piece?(grid, [column_up, row])
      unless is_same_color?(grid, square, [column_up, row])
        possible_movements.push([column_up, row])
      end
    elsif column_up >= 0 && row >= 0
      possible_movements.push([column_up, row])
    end
  end

  def find_possible_movement_right_knight(grid, square)
    column_up = square[0] - 1
    column_down = square[0] + 1
    row = square[1] + 2
    if column_down <= 7 && row <= 7 && is_piece?(grid, [column_down, row])
      unless is_same_color?(grid, square, [column_down, row])
        possible_movements.push([column_down, row]) 
      end
    elsif column_down <= 7 && row <= 7
      possible_movements.push([column_down, row])
    end
    if column_up >= 0 && row <= 7 && is_piece?(grid, [column_up, row])
      unless is_same_color?(grid, square, [column_up, row])
        possible_movements.push([column_up, row]) 
      end
    elsif column_up >= 0 && row <= 7
      possible_movements.push([column_up, row])
    end
  end

  def find_possible_movement_left_up(grid, square) # For bishop and queen
    column = square[0] - 1
    row = square[1] - 1
    until column < 0 || row < 0
      if is_piece?(grid, [column, row])
        if is_same_color?(grid, square, [column, row])
          break
        else
          possible_movements.push([column, row])
          break
        end
      else
        possible_movements.push([column, row])
        column -= 1
        row -= 1
      end
    end
  end
     
  def find_possible_movement_left_down(grid, square) # For bishop and queen
    column = square[0] + 1
    row = square[1] - 1
    until column > 7 || row < 0
      if is_piece?(grid, [column, row])
        if is_same_color?(grid, square, [column, row])
          break
        else
          possible_movements.push([column, row])
          break
        end
      else
        possible_movements.push([column, row])
        column += 1
        row -= 1
      end
    end
  end
    
  def find_possible_movement_right_up(grid, square) # For bishop and queen
    column = square[0] - 1
    row = square[1] + 1
    until column < 0 || row > 7
      if is_piece?(grid, [column, row])
        if is_same_color?(grid, square, [column, row])
          break
        else
          possible_movements.push([column, row])
          break
        end
      else
        possible_movements.push([column, row])
        column -= 1
        row += 1
      end
    end
  end
    
  def find_possible_movement_right_down(grid, square) # For bishop and queen
    column = square[0] + 1
    row = square[1] + 1
    until column > 7 || row > 7
      if is_piece?(grid, [column, row])
        if is_same_color?(grid, square, [column, row])
          break
        else
          possible_movements.push([column, row])
          break
        end
      else
        possible_movements.push([column, row])
        column += 1
        row += 1
      end
    end
  end
    
  def move_one_column(grid, square) #For king
    column = square[0] - 1
    if column >= 0 && is_piece?(grid, [column, square[1]])
      unless is_same_color?(grid, square, [column, square[1]])
        possible_movements.push([column, square[1]])
      end
    elsif column >= 0 && !is_piece?(grid, [column, square[1]])
      possible_movements.push([column, square[1]])
    end
    column += 2
    if column <= 7 && is_piece?(grid, [column, square[1]])
      unless is_same_color?(grid, square, [column, square[1]])
        possible_movements.push([column, square[1]])
      end
    elsif column <= 7 && !is_piece?(grid, [column, square[1]])
      possible_movements.push([column, square[1]])
    end
  end

  def move_one_row(grid, square) #For king
    row = square[1] -1
    if row >= 0 && is_piece?(grid, [square[0], row])
      unless is_same_color?(grid, square, [square[0], row])
        possible_movements.push([square[0], row]) 
      end
    elsif row >= 0 && !is_piece?(grid, [square[0], row])
      possible_movements.push([square[0], row])
    end
    row += 2
    if row <= 7 && is_piece?(grid, [square[0], row])
      unless is_same_color?(grid, square, [square[0], row])
        possible_movements.push([square[0], row])
      end
    elsif row <= 7 && !is_piece?(grid, [square[0], row])
      possible_movements.push([square[0], row])
    end
  end

  def move_one_left_diagonal(grid, square) #For king
    column = square[0] - 1
    row = square[1] - 1
    if column >= 0 && row >= 0 && is_piece?(grid, [column, row])
      unless is_same_color?(grid, square, [column, row])
        possible_movements.push([column, row])
      end
    elsif column >= 0 && row >= 0 && !is_piece?(grid, [column, row])
      possible_movements.push([column, row])
    end
    column += 2
    row += 2
    if column <= 7 && row <= 7 && is_piece?(grid, [column, row])
      unless is_same_color?(grid, square, [column, row])
        possible_movements.push([column, row])
      end
    elsif column <= 7 && row <= 7 && !is_piece?(grid, [column, row])
      possible_movements.push([column, row])
    end
  end

  def move_one_right_diagonal(grid, square) #For king
    column = square[0] - 1
    row = square[1] + 1
    if column >= 0 && row <= 7 && is_piece?(grid, [column, row])
      unless is_same_color?(grid, square, [column, row])
        possible_movements.push([column, row])
      end 
    elsif column >= 0 && row <= 7 && !is_piece?(grid, [column, row])
      possible_movements.push([column, row])
    end
    column += 2
    row -= 2
    if column <= 7 && row >= 0 && is_piece?(grid, [column, row])
      unless is_same_color?(grid, square, [column, row])
        possible_movements.push([column, row])
      end
    elsif column <= 7 && row >= 0 && !is_piece?(grid, [column, row])
      possible_movements.push([column, row])
    end
  end

  def move_to(grid, square_from, square_to, is_for_check=false)
    piece = grid[square_from[0]][square_from[1]].split(" ")
    piece = piece[1]    
    delete_moved_piece(grid, square_from)
    move_piece(grid, square_to, piece)
    if is_for_check == false 
      i = 0
      until i == possible_movements.length
        unmark_possible_movement(grid, possible_movements[i])
        i += 1
      end
    end
    if piece == "♟" || piece == "♙"
      check_pawn_promotion(grid, square_to, recognice_piece_color(piece))
    end
    if piece == "♚" || piece == "♔"
      check_moving_castle(grid, square_from, square_to)
    end
  end
end