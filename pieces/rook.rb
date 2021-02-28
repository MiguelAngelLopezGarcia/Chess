require "./pieces/pieces.rb"

class Rook < Piece
  attr_accessor :possible_movements
    def put_rooks(grid)
      grid[0][0] = " ♜ "
      grid[0][7] = " ♜ "
      grid[7][0] = " ♖ "
      grid[7][7] = " ♖ "
    end

    def select_piece(grid, square)
      @possible_movements = []
      find_possible_movement_row(grid, square)
      find_possible_movement_column(grid, square)
    end
    
    def find_possible_movement_row(grid, square)
      row = square[0].clone
      i = square[1].clone - 1
      j = square[1].clone + 1
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
      column = square[1].clone
      i = square[0].clone - 1
      j = square[0].clone + 1
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
       
  end
  