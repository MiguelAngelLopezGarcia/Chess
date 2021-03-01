require "./pieces/pieces.rb"

module Movements
    def find_possible_movement_pawn(grid, square, color)
        if color == "b"
          possible_square = square[0] + 1
          possible_movements.push([possible_square, square[1]])
          mark_possible_movement(grid, [possible_square, square[1]])
        elsif color == "w"
          possible_square = square[0] - 1
          possible_movements.push([possible_square, square[1]])
          mark_possible_movement(grid, [possible_square, square[1]])
        end
    end
    
    def find_possible_movement_initial_square_pawn(grid, square, color)
        possible_square = square[0]
        if color == "b"
          2.times do
            possible_square += 1
            possible_movements.push([possible_square, square[1]])
            mark_possible_movement(grid, [possible_square, square[1]])
          end
        elsif color == "w"
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
        until i < 0
          possible_movements.push([row, i])
          mark_possible_movement(grid, [row, i])
          i -= 1
        end
        until j > 7
          possible_movements.push([row, j])
          mark_possible_movement(grid, [row, j])
          j += 1
        end
    end
    
    def find_possible_movement_column(grid, square)
        column = square[1]
        i = square[0] - 1
        j = square[0] + 1
        until i < 0
          possible_movements.push([i, column])
          mark_possible_movement(grid, [i, column])
          i -= 1
        end
        until j > 7
          possible_movements.push([j, column])
          mark_possible_movement(grid, [j, column])
          j += 1
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
    

end