#Se dibuja el tablero en pantalla. Puede ser un conjunto de arrays 8x8. A los bordes tiene que haber la numeración (A-G, 1-8)
#Background alternado negro y blanco. 
#Después de colorearlos se generan las piezas.
#La pieza se selecciona escribiendo su casilla.
#Al seleccionar una pieza se marca los posibles movimientos.
#Se marca en rojo el background cuando puede comer una pieza
#De igual manera se cambia el background a rojo cuando el rey está en jaque
#Al seleccionar la casilla con un movimiento válido se actualiza el array con la pieza movida, los backgrounds y las localizaciones de los posibles movimientos
#Si el usuario elige una casilla no válida se le avisa y vuelve a repetir
#A tener en cuenta: enroque, peones en primera fila mueven doble, jaques, tablas (repetir el movimiento los dos jugadores 4 veces), softlock o como se diga, peón se convierte al llegar al final, posibles movimientos válidos

Dir[File.join(__dir__, 'pieces', '*.rb')].each { |file| require file }

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
    Knight.new.put_knights(grid)
    Bishop.new.put_bishops(grid)
    Queen.new.put_queens(grid)
    King.new.put_kings(grid)
  end

  def prueba(grid)
    possible_movements = []
    square_from = []
    square_from[0] = gets.chomp.to_i
    square_from[1] = gets.chomp.to_i
    a = Rook.new
    a.select_piece(grid, square_from.clone)
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
