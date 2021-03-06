require "yaml"
require "colorize"
require 'pry'
require "./game.rb"

class Wellcome
    attr_accessor :language, :colored_pawn, :red_dot, :attacked_pawn
    def initialize
        @colored_pawn = " ♟ ".colorize(:background => :blue)
        @red_dot = " ● ".colorize(:color => :red, :background => :light_yellow)
        @attacked_pawn = " ♟ ".colorize(:background => :red)
    end

    def start
        Gem.win_platform? ? (system "cls") : (system "clear")
        puts "Please write \"E\" and press enter if you want the game to be in English."
        puts "Por favor, escribe \"S\" y pulsa enter si quieres que el juego esté en español."
        @language = gets.chomp.downcase
        until @language == "e" || @language == "s"
            puts "Please write \"E\" and press enter if you want the game to be in English."
            puts "Por favor, escribe \"S\" y pulsa enter si quieres que el juego esté en español."
            @language = gets.chomp.downcase
        end    
        if language == "e"
            wellcome_in_english
        else
            wellcome_in_spanish
        end
    end

    #Hacer cambio de selección de pieza y explicar el en passant

    def wellcome_in_english
        Gem.win_platform? ? (system "cls") : (system "clear")
        puts "Wellcome to this chess game! I'm going to explain you haw to play:"
        puts "In order to select a piece write first the letter of column and then the number. Your piece will be selected and"
        puts "the background will be colored in blue like this #{colored_pawn}\nThe valid moves that this piece have will be shown as a red dot like this #{red_dot}"
        puts "When a piece is attacked it's background will be colored in red #{attacked_pawn} There are two situations where you can't take the piece with"
        puts "the red background: when your king is in check and when you are goin to take a pawn \"en passant\" that your pawn will end in a different"
        puts "square that the attacked pawn."
        puts "In order to move the piece just select the column and then the number of a valid square (both with a dot or an attacked piece)"
        puts "\n\nNow that you know how to play, would you like to start a new game or to load a previous saved game?"
        puts "Write \"N\" and press enter to start a new game or write \"L\" and press enteer to load a saved game"
        input = gets.chomp.downcase
        until input == "n" || input == "l"
            puts "Write \"N\" to start a new game or write \"L\" to load a saved game"
            input = gets.chomp.downcase
        end
        if input == "n"
            Game.new("e").start_game
        else
            if File.exists? ("save/save_file.dump") 
                puts "Game loaded\n"
                game = YAML.load(File.read("save/save_file.dump"))
                game.language = "e"
                game.start_game_from_save_file
            else
                Game.new("e").start_game_file_not_found
            end
        end    
    end

    def wellcome_in_spanish
        Gem.win_platform? ? (system "cls") : (system "clear")
        puts "Bienvenidos y bienvenidas a este juego de ajedrez. Os voy a explicar cómo funciona:"
        puts "Para seleccionar una ficha escribid primero la letra de la columna y luego el número de la fila. Vuestra pieza será"
        puts "seleccionada y tendrá un fondo azul como este #{colored_pawn}\nLos movimientos válidos de esta pieza se representarán como puntos rojos como este #{red_dot}"
        puts "Cuando una pieza sea atacada su fondo cambiará a rojo #{attacked_pawn} Hay dos situaciones donde no puedes seleccionar"
        puts "la ficha atacada: cuando estás jaque y tu rey es el marcado en rojo o cuando puedes comer un peón al paso (se marca el peón pero"
        puts "tu peón no queda en esa casilla)"
        puts "Para mover la ficha selecciona primero la columna y luego la fila de una casilla válida (tanto un punto rojo como una pieza atacada)"
        puts "\n\nAhora que sabes jugar, ¿te gustaría empezar una nueva partida o cargar una ya guardada?"
        puts "Escribe \"N\" y pulsa enter para empezar una nueva partida o escribe \"L\" y pulsa enter para cargar una partida guardada"
        input = gets.chomp.downcase
        until input == "n" || input == "l"
            puts "Escribe \"N\" y pulsa enter para empezar una nueva partida o escribe \"L\" y pulsa enter para cargar una partida guardada"
            input = gets.chomp.downcase
        end
        if input == "n"
            Game.new("s").start_game
        else
            if File.exists? ("save/save_file.dump") 
                puts "Game loaded\n"
                game = YAML.load(File.read("save/save_file.dump"))
                game.language = "s"
                game.start_game_from_save_file
            else
                Game.new("s").start_game_file_not_found
            end
        end    

    end
end

Wellcome.new.start
# [:black, :light_black, :red, :light_red, :green, :light_green, :yellow, :light_yellow, :blue, :light_blue, :magenta, :light_magenta, :cyan, :light_cyan, :white, :light_white, :default]
