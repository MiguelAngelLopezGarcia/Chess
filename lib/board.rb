Dir[File.join(__dir__, 'pieces', '*.rb')].each { |file| require file }
require "./players.rb"

class Board
  attr_accessor :grid
  def initialize
    @grid = make_grid
  end

  def make_grid
    grid = []
    8.times do
      grid.push(Array.new(8, "   "))
    end
    grid
  end

  def display_grid(color="n")
    Gem.win_platform? ? (system "cls") : (system "clear")
    i = 0
    j = 8
    board_letters = "    A  B  C  D  E  F  G  H"
    puts board_letters
    until i >= grid.size do
      color == "n" ? this_grid = join_grid(grid[i]) : this_grid = i.even? ? color_it(grid[i]) : color_it(grid[i], 1)
        puts "#{j}  #{this_grid}  #{j}"
        i += 1
        j -= 1
    end
    puts board_letters
  end

  def color_it(row, i=0)
    row.each_with_index do|letter, index|
      if index.even?
        i == 0 ? row[index] = letter.colorize(:background => :light_black) : row[index] = letter.colorize(:background => :black)
      elsif index.odd?
        i == 0 ? row[index] = letter.colorize(:background => :black) : row[index] = letter.colorize(:background => :light_black)
      end
    end
    row.join("")
  end

  def join_grid(row)
    row.join("")
  end

  def insert_pieces
    Pawn.new.put_pawns(grid)
    Rook.new.put_rooks(grid)
    Knight.new.put_knights(grid)
    Bishop.new.put_bishops(grid)
    Queen.new.put_queens(grid)
    King.new.put_kings(grid)
  end

  def find_king_and_mark_it(grid, player, i=0)
    i == 0 ? color = player.color : player.color == "b" ? color = "w" : color = "b"
    grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        piece = Piece.new.isolate_my_piece(grid, [i, j])
        if piece == "♚" && color == "w"
          Piece.new.mark_atacked_piece(grid, [i, j])
          return
        elsif piece == "♔" && color == "b"
          Piece.new.mark_atacked_piece(grid, [i, j])
          return
        end
      end
    end
  end

  def is_mate?(player_in_turn, other_player)
    player_in_turn.possible_squares = []
    player_in_turn.pieces_availables = []
    grid.each_with_index do |row, i|
        row.each_with_index do |this_square, j|
          new_grid = YAML.load(YAML.dump(grid))
            piece = Piece.new.isolate_my_piece(grid, [i, j])
            case 
            when piece == "♟" && player_in_turn.color == "b" || piece == "♙" && player_in_turn.color == "w"
              this_piece = Pawn.new
              this_piece.select_piece(new_grid, [i, j], player_in_turn, other_player)
              if this_piece.possible_movements.length > 0
                player_in_turn.possible_squares.push([i, j])
                player_in_turn.pieces_availables.push(this_piece)
              end
            when piece == "♜" && player_in_turn.color == "b" || piece == "♖" && player_in_turn.color == "w"
              this_piece = Rook.new
              this_piece.select_piece(new_grid, [i, j], player_in_turn)
              if this_piece.possible_movements.length > 0
                player_in_turn.possible_squares.push([i, j])
                player_in_turn.pieces_availables.push(this_piece)
              end
            when piece == "♞" && player_in_turn.color == "b" || piece == "♘" && player_in_turn.color == "w"
              this_piece = Knight.new
              this_piece.select_piece(new_grid, [i, j], player_in_turn)
              if this_piece.possible_movements.length > 0
                player_in_turn.possible_squares.push([i, j])
                player_in_turn.pieces_availables.push(this_piece)
              end
            when piece == "♝" && player_in_turn.color == "b" || piece == "♗" && player_in_turn.color == "w"
              this_piece = Bishop.new
              this_piece.select_piece(new_grid, [i, j], player_in_turn)
              if this_piece.possible_movements.length > 0
                player_in_turn.possible_squares.push([i, j])
                player_in_turn.pieces_availables.push(this_piece)
              end
            when piece == "♛" && player_in_turn.color == "b" || piece == "♕" && player_in_turn.color == "w"
              this_piece = Queen.new
              this_piece.select_piece(new_grid, [i, j], player_in_turn)
              if this_piece.possible_movements.length > 0
                player_in_turn.possible_squares.push([i, j])
                player_in_turn.pieces_availables.push(this_piece)
              end
            when piece == "♚" && player_in_turn.color == "b" || piece == "♔" && player_in_turn.color == "w"
              this_piece = King.new
              this_piece.select_piece(new_grid, [i, j], player_in_turn)
              if this_piece.possible_movements.length > 0
                player_in_turn.possible_squares.push([i, j])
                player_in_turn.pieces_availables.push(this_piece)
              end
            end
        end
    end
    return true if player_in_turn.possible_squares.empty?
  end

  def is_in_check?(player)
    grid.each_with_index do |row, i|
        row.each_with_index do |this_square, j|
            piece = Piece.new.isolate_my_piece(grid, [i, j])
            case 
            when piece == "♟" || piece == "♙"
              this_piece = Pawn.new
              if this_piece.is_in_check_pre_movement?(grid, [i, j], player)
                return true
              end
            when piece == "♜" || piece == "♖"
              this_piece = Rook.new
              if this_piece.is_in_check_pre_movement?(grid, [i, j], player)
                return true
              end
            when piece == "♞" || piece == "♘"
              this_piece = Knight.new
              if this_piece.is_in_check_pre_movement?(grid, [i, j], player)
                return true
              end
            when piece == "♝" || piece == "♗"
              this_piece = Bishop.new
              if this_piece.is_in_check_pre_movement?(grid, [i, j], player)
                return true
              end
            when piece == "♛" || piece == "♕"
              this_piece = Queen.new
              if this_piece.is_in_check_pre_movement?(grid, [i, j], player)
                return true
              end
            when piece == "♚" || piece == "♔"
              this_piece = King.new
              if this_piece.is_in_check_pre_movement?(grid, [i, j], player)
                return true
              end
            end
        end
    end
    return false
  end

  def chek_if_king_or_rook_moved(player, square)
    piece = Piece.new.isolate_my_piece(grid, square)
    if player.is_possible_to_castle? == true && piece == "♚" || piece == "♔"
      player.king_moved = true
    elsif player.is_possible_to_castle? == true && piece == "♜" || piece == "♖"
      Rook.new.check_rook_move(grid, square, player)
    end
  end

end