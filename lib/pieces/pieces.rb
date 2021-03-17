class Piece
  def recognice_piece(piece)
    pawn = ["♟", "♙"]
    rook = ["♜", "♖"]
    knight = ["♞", "♘"]
    bishop = ["♝", "♗"]
    queen = ["♛", "♕"]
    king = ["♚", "♔"]
    if pawn.include? piece
      return "p"
    elsif rook.include? piece
      return "r"
    elsif knight.include? piece
      return "k"
    elsif bishop.include? piece
      return "b"
    elsif queen.include? piece
      return "q"
    elsif king.include? piece
      return "k"
    end
  end
  
  def recognice_piece_color (piece)
    black = ["♟", "♜", "♞", "♝", "♛", "♚"]
    white = ["♙", "♖", "♘", "♗", "♕", "♔"]
    if black.include? piece
      return "b"
    elsif white.include? piece
      return "w"
    end
  end

  def move_piece(grid, square, piece, player)
    piece_to_move = grid[square[0]][square[1]].split(" ")
    piece_to_move[1] = piece
    piece_to_move = piece_to_move.join(" ")
    grid[square[0]][square[1]] = piece_to_move
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:color => :default)
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:color => :black) if player.color == "b"
  end

  def delete_moved_piece(grid, square)
    piece_to_delete = grid[square[0]][square[1]].split(" ")
    piece_to_delete[1] = " "
    piece_to_delete = piece_to_delete.join(" ")
    grid[square[0]][square[1]] = piece_to_delete
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:color => :default)
  end

  def mark_possible_movement(grid, square)
    if is_piece?(grid, square)
      mark_atacked_piece(grid, square)
    else
      possible_movement = grid[square[0]][square[1]].split(" ")
      possible_movement.push("")
      possible_movement[2] = possible_movement[1]
      possible_movement[1] = "●"
      possible_movement = possible_movement.join(" ")
      grid[square[0]][square[1]] = possible_movement.colorize(:red)
    end
  end

  def unmark_possible_movement(grid, square)
    piece_to_delete = grid[square[0]][square[1]].split(" ")
    if piece_to_delete[1] == "●"
      piece_to_delete[1] = " "
      piece_to_delete = piece_to_delete.join(" ")
      grid[square[0]][square[1]] = piece_to_delete
    end
    if recognice_piece_color(isolate_my_piece(grid, square)) == "b"
       grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:color => :black)
    else
      grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:color => :default)
    end
  end
  
  def mark_atacked_piece(grid, square)
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:background => :red)
  end

  def is_piece?(grid, square)
    piece = isolate_my_piece(grid, square)
    is_piece = recognice_piece(piece)
    if is_piece.class == String
      return true
    else
      return false
    end
  end

  def is_same_color?(grid, square_from, square_to)
    my_piece = isolate_my_piece(grid, square_from)
    other_piece = isolate_my_piece(grid, square_to)
    my_piece_color = recognice_piece_color(my_piece)
    other_piece_color = recognice_piece_color(other_piece)
    if my_piece_color == other_piece_color
      return true
    else
      return false
    end
  end

  def color_this_square(grid, square)
    grid[square[0]][square[1]] = grid[square[0]][square[1]].colorize(:background => :light_blue)
  end

  def validate_my_movements(grid, array, square_from, player)
    squares_to_delete = []
    array.each do |square|
      new_grid = YAML.load(YAML.dump(grid))
      array.map {|this_square| mark_possible_movement(new_grid, this_square)}
      move_to(new_grid, square_from, square, true, player)
      new_grid.each_with_index do |row, i|
        row.each_with_index do |this_square, j|
          piece = isolate_my_piece(grid, [i, j])
          case 
          when piece == "♟" || piece == "♙"
            this_piece = Pawn.new
            if this_piece.is_in_check_pre_movement?(new_grid, [i, j], player)
              squares_to_delete.push(square)
              break
            end
          when piece == "♜" || piece == "♖"
            this_piece = Rook.new
            if this_piece.is_in_check_pre_movement?(new_grid, [i, j], player)
              squares_to_delete.push(square)
              break
            end
          when piece == "♞" || piece == "♘"
            this_piece = Knight.new
            if this_piece.is_in_check_pre_movement?(new_grid, [i, j], player)
              squares_to_delete.push(square)
              break
            end
          when piece == "♝" || piece == "♗"
            this_piece = Bishop.new
            if this_piece.is_in_check_pre_movement?(new_grid, [i, j], player)
              squares_to_delete.push(square)
              break
            end
          when piece == "♛" || piece == "♕"
            this_piece = Queen.new
            if this_piece.is_in_check_pre_movement?(new_grid, [i, j], player)
              squares_to_delete.push(square)
              break
            end
          when piece == "♚" || piece == "♔"
            this_piece = King.new
            if this_piece.is_in_check_pre_movement?(new_grid, [i, j], player)
              squares_to_delete.push(square)
              break
            end
          end
        end
      end
    end
    squares_to_delete.each do |square|
      array.delete(square)
    end
  end

  def isolate_my_piece(grid, square)
    piece = grid[square[0]][square[1]].split(" ")
    piece = piece[1]
    return piece
  end

end
