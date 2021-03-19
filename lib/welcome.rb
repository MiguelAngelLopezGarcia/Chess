require "./lib/game.rb"

class Welcome
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
            welcome_in_english
        else
            welcome_in_spanish
        end
        #binding.pry
    end

    def welcome_in_english
        Gem.win_platform? ? (system "cls") : (system "clear")
        puts "Welcome to this chess game! I'm going to explain you haw to play:\nBlack pieces will be represented as blue color."
        puts "In order to select a piece write first the letter of column and then the number. Your piece will be selected and"
        puts "the background will be colored in blue like this #{colored_pawn}\nThe valid moves that this piece have will be shown as a red dot like this #{red_dot}"
        puts "When a piece is attacked it's background will be colored in red #{attacked_pawn} There is one situation where you can't take the piece with"
        puts "the red background: when you are goin to take a pawn \"en passant\" that your pawn will end in a different square that the attacked pawn."
        puts "In order to move the piece just select the column and then the number of a valid square (both with a dot or an attacked piece)"
        puts "\n\nNow that you know how to play, would you like to start a new game or to load a previous saved game?"
        puts "Write \"N\" and press enter to start a new game or write \"L\" and press enteer to load a saved game"
        input = get_input
        start_game_according_to_input(input)
    end

    def welcome_in_spanish
        Gem.win_platform? ? (system "cls") : (system "clear")
        puts "Bienvenidos y bienvenidas a este juego de ajedrez. Os voy a explicar cómo funciona:\nLas piezas negras se representan en azul."
        puts "Para seleccionar una ficha escribid primero la letra de la columna y luego el número de la fila. Vuestra pieza será"
        puts "seleccionada y tendrá un fondo azul como este #{colored_pawn}\nLos movimientos válidos de esta pieza se representarán como puntos rojos como este #{red_dot}"
        puts "Cuando una pieza sea atacada su fondo cambiará a rojo #{attacked_pawn} Hay una situación donde no puedes seleccionar"
        puts "la ficha atacada: cuando puedes comer un peón al paso, se marca el peón enemigo pero tu peón no queda en esa casilla."
        puts "Para mover la ficha selecciona primero la columna y luego la fila de una casilla válida (tanto un punto rojo como una pieza atacada)"
        puts "\n\nAhora que sabes jugar, ¿te gustaría empezar una nueva partida o cargar una ya guardada?"
        puts "Escribe \"N\" y pulsa enter para empezar una nueva partida o escribe \"L\" y pulsa enter para cargar una partida guardada"
        input = get_input
        start_game_according_to_input(input)
    end

    def get_input
        input = gets.chomp.downcase
        until input == "n" || input == "l"
            puts "Escribe \"N\" y pulsa enter para empezar una nueva partida o escribe \"L\" y pulsa enter para cargar una partida guardada" if language == "s"
            puts "Write \"N\" to start a new game or write \"L\" to load a saved game" if language == "e"
            input = gets.chomp.downcase
        end
    end

    def start_game_according_to_input(input)
        if input == "n"
            Game.new(language).start_game
        else
            if File.exists? ("save/save_file.dump") 
                game = YAML.load(File.read("save/save_file.dump"))
                game.language = language
                game.start_game_from_save_file
            else
                Game.new(language).start_game_file_not_found
            end
        end
    end

end

Welcome.new.start