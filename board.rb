#La pieza se selecciona escribiendo su casilla.
#Si el usuario elige una casilla no válida se le avisa y vuelve a repetir
#A tener en cuenta:  tablas (repetir el movimiento los dos jugadores 4 veces), stalemate

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

  def display_grid_first_time
    insert_pieces
    display_clear_grid
    prueba(grid)
  end

  def display_clear_grid 
    Gem.win_platform? ? (system "cls") : (system "clear")
    i = 0
    j = 8
    puts "    A  B  C  D  E  F  G  H"
    until i >= grid.size do
      if i.even?
        puts "#{j}  #{color_it(grid[i])}  #{j}"
        i += 1
        j -= 1
      else
        puts "#{j}  #{color_it(grid[i], 1)}  #{j}"
        i += 1
        j -= 1
      end
    end
    puts "    A  B  C  D  E  F  G  H"
  end

  def display_grid
    Gem.win_platform? ? (system "cls") : (system "clear")
    i = 0
    j = 8
    puts "    A  B  C  D  E  F  G  H"
    until i >= grid.size do
      puts "#{j}  #{join_grid(grid[i])}  #{j}"
      i += 1
      j -= 1
    end
    puts "    A  B  C  D  E  F  G  H"
  end

  def color_it(row, i=0)
    if i == 0
      row.each_with_index do|letter, index|
        if index.even?
          row[index] = letter.colorize(:background => :light_yellow)
        elsif index.odd?
          row[index] = letter.colorize(:background => :black)
        end
      end
    else
      row.each_with_index do|letter, index|
        if index.odd?
          row[index] = letter.colorize(:background => :light_yellow)
        elsif index.even?
          row[index] = letter.colorize(:background => :black)
        end
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

  def create_piece_class(square)
    piece = grid[square[0]][square[1]].split(" ")
    piece = piece[1]
    case
    when piece == "♟" || piece == "♙"
      this_piece = Pawn.new
    when piece == "♜" || piece == "♖"
      this_piece = Rook.new
    when piece == "♞" || piece == "♘"
      this_piece = Knight.new
    when piece == "♝" || piece == "♗"
      this_piece = Bishop.new
    when piece == "♛" || piece == "♕"
      this_piece = Queen.new
    when piece == "♚" || piece == "♔"
      this_piece = King.new
    end
    return this_piece
  end

  def am_i_checking(player)
    grid.each_with_index do |row, i|
      row.each_with_index do |this_square, j|
        piece = this_square.split(" ")
        piece = piece[1]
        case
        when piece == "♟" || piece == "♙"
          this_piece = Pawn.new
          if this_piece.is_in_check_post_movement?(grid, [i, j], player)
            find_king_and_mark_it(grid, player)
            return
          end
        when piece == "♜" || piece == "♖"
          this_piece = Rook.new
          if this_piece.is_in_check_post_movement?(grid, [i, j], player)
            find_king_and_mark_it(grid, player)
            return
          end
        when piece == "♞" || piece == "♘"
          this_piece = Knight.new
          if this_piece.is_in_check_post_movement?(grid, [i, j], player)
            find_king_and_mark_it(grid, player)
            return
          end
        when piece == "♝" || piece == "♗"
          this_piece = Bishop.new
          if this_piece.is_in_check_post_movement?(grid, [i, j], player)
            find_king_and_mark_it(grid, player)
            return
          end
        when piece == "♛" || piece == "♕"
          this_piece = Queen.new
          if this_piece.is_in_check_post_movement?(grid, [i, j], player)
            find_king_and_mark_it(grid, player)
            return
          end
        end
      end
    end
  end

  def find_king_and_mark_it(grid, player)
    grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        piece = square.split(" ")
        piece = piece[1]
        if piece == "♚" && player.color == "w"
          Piece.new.mark_atacked_piece(grid, [i, j])
          return
        elsif piece == "♔" && player.color == "b"
          Piece.new.mark_atacked_piece(grid, [i, j])
          return
        end
      end
    end
  end

  def is_mate?(player)
    grid.each_with_index do |row, i|
        row.each_with_index do |this_square, j|
          new_grid = YAML.load(YAML.dump(grid))
            piece = this_square.split(" ")
            piece = piece[1]
            case 
            when piece == "♟" && player.color == "b" || piece == "♙" && player.color == "w"
              this_piece = Pawn.new
              this_piece.select_piece(new_grid, [i, j], player)
              if this_piece.possible_movements.length > 0
                player.possible_squares.push([i, j])
              end
            when piece == "♜" && player.color == "b" || piece == "♖" && player.color == "w"
              this_piece = Rook.new
              this_piece.select_piece(new_grid, [i, j], player)
              if this_piece.possible_movements.length > 0
                player.possible_squares.push([i, j])
              end
            when piece == "♞" && player.color == "b" || piece == "♘" && player.color == "w"
              this_piece = Knight.new
              this_piece.select_piece(new_grid, [i, j], player)
              if this_piece.possible_movements.length > 0
                player.possible_squares.push([i, j])
              end
            when piece == "♝" && player.color == "b" || piece == "♗" && player.color == "w"
              this_piece = Bishop.new
              this_piece.select_piece(new_grid, [i, j], player)
              if this_piece.possible_movements.length > 0
                player.possible_squares.push([i, j])
              end
            when piece == "♛" && player.color == "b" || piece == "♕" && player.color == "w"
              this_piece = Queen.new
              this_piece.select_piece(new_grid, [i, j], player)
              if this_piece.possible_movements.length > 0
                player.possible_squares.push([i, j])
              end
            when piece == "♚" && player.color == "b" || piece == "♔" && player.color == "w"
              this_piece = King.new
              this_piece.select_piece(new_grid, [i, j], player)
              if this_piece.possible_movements.length > 0
                player.possible_squares.push([i, j])
              end
            end
        end
    end
    return true if player.possible_squares.nil?
  end

  def is_in_check?(grid)
    grid.each_with_index do |row, i|
        row.each_with_index do |this_square, j|
            piece = this_square.split(" ")
            piece = piece[1]
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

end