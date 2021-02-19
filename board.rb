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
require "./pieces.rb"

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

  def display
    puts `clear`
    insert_pieces
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

  def color_it(row, i=0)
    if i == 0
      row.each_with_index do|letter, index|
        if index.even?
          row[index] = letter.colorize(:background => :white)
        end
      end
    else
      row.each_with_index do|letter, index|
        if index.odd?
          row[index] = letter.colorize(:background => :white)
        end
      end
    end
    row.join("")
  end

  def insert_pieces
    insert_pawns
    insert_rooks
    insert_knights
    insert_bishops
    insert_queens
    insert_kings
  end

  def insert_pawns
    Pawn.new.put_pawns(grid)
  end

  def insert_rooks
    Rook.new.put_rooks(grid)
  end

  def insert_knights
    Knight.new.put_knights(grid)
  end

  def insert_bishops
    Bishop.new.put_bishops(grid)
  end

  def insert_queens
    Queen.new.put_queens(grid)
  end

  def insert_kings
    King.new.put_kings(grid)
  end
end

Board.new.display