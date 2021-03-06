#La pieza se selecciona escribiendo su casilla.
#De igual manera se cambia el background a rojo cuando el rey está en jaque
#Si el usuario elige una casilla no válida se le avisa y vuelve a repetir
#A tener en cuenta: enroque, peones en primera fila mueven doble, jaques, tablas
  #(repetir el movimiento los dos jugadores 4 veces), softlock o como se diga,
  #peón se convierte al llegar al final, posibles movimientos válidos
  #Puedes mover y comer piezas para cubrir el jaque

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
    j = 1
    puts "    A  B  C  D  E  F  G  H"
    until i >= grid.size do
      if i.even?
        puts "#{j}  #{color_it(grid[i])}  #{j}"
        i += 1
        j += 1
      else
        puts "#{j}  #{color_it(grid[i], 1)}  #{j}"
        i += 1
        j += 1
      end
    end
    puts "    A  B  C  D  E  F  G  H"
  end

  def display_grid
    Gem.win_platform? ? (system "cls") : (system "clear")
    i = 0
    j = 1
    puts "    A  B  C  D  E  F  G  H"
    until i >= grid.size do
      puts "#{j}  #{join_grid(grid[i])}  #{j}"
      i += 1
      j += 1
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
    # Knight.new.put_knights(grid)
    # Bishop.new.put_bishops(grid)
    # Queen.new.put_queens(grid)
    King.new.put_kings(grid)
  end

  def prueba(grid)
    player = Player.new("w")
    possible_movements = []
    square_from = []
    square_from[0] = gets.chomp.to_i
    square_from[1] = gets.chomp.to_i
    a = King.new
    a.select_piece(grid, square_from, player)
    display_grid
    square_to = []
    square_to[0] = gets.chomp.to_i
    square_to[1] = gets.chomp.to_i
    a.move_to(grid, square_from, square_to)
    display_clear_grid
  end
end

a = Board.new
a.display_grid_first_time
