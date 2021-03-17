require "./board.rb"

class Game
    attr_accessor :language, :player_one, :player_two, :board
    def initialize(language)
        @language = language
        @player_one = Player.new("w", "white", "blancas")
        @player_two = Player.new("b", "black", "negras")
        @board = Board.new
    end

    def start_game
        board.insert_pieces
        board.display_grid("y")
        play_game(player_one, player_two, board)
    end

    def start_game_from_save_file
        board.display_grid
        puts "Game loaded" if language == "e"
        puts "Partida cargada" if language == "s" 
        play_game(player_one, player_two, board)
    end

    def start_game_file_not_found
        board.insert_pieces
        board.display_grid("y")
        puts "File not found, starting a new game" if language == "e"
        puts "Archivo de guardado no encontrado, empezando un nuevo juego" if language == "s"
        play_game(player_one, player_two, board)
    end

    def play_game(player_one, player_two, board)
        player_verification = "w"
        until board.is_mate?(player_one, player_two)
            if player_one.turn == 1
                round = play_round(board, player_one)
            end
            break if round == "draw"
            player_two.turn = 1
            if board.is_mate?(player_two, player_one)
                player_verification = "b"
                break
            end
            round = play_round(board, player_two)
            break if round == "draw"
            player_one.turn = 1
        end
        if player_verification == "w"
            player = player_one
            other_player = player_two
        else
            player = player_two
            other_player = player_one
        end
        if board.is_mate?(player, other_player)
            if board.is_in_check?(player)
                game_over_checkmate(player)
            else
                game_over_satalemate(player)
            end
        else
            game_over_draw
        end
    end

    def play_round(board, player)
        board.find_king_and_mark_it(board.grid, player, 1) if board.is_in_check?(player)
        board.display_grid
        square_from = get_square(player, 1) until is_valid_square?(square_from, player)
        return "draw" if square_from == "y"
        selected_piece = ""
        player.possible_squares.each_with_index do |square, i|
            if square == square_from
                selected_piece = player.pieces_availables[i]
            end
        end
        board.grid = selected_piece.grid
        board.display_grid
        square_to = get_square(player, 2) until is_valid_square?(square_to, player, selected_piece)
        return "draw" if square_to == "y"
        board.chek_if_king_or_rook_moved(player, square_from)
        selected_piece.move_to(board.grid, square_from, square_to)
        player.turn = 0
        player.previous_move = [square_from, square_to]
        board.display_grid("y")
    end
    
    def get_square(player, number)

        if number == 1
            if language == "e"
                puts "It's #{player.color_english}'s turn. To select your piece write the letter of the column," 
                puts "press enter and then the number of the row and press enter again. To save the game type \"S\" and press enter."
                puts "To offer a draw type \"T\" and press enter."
            else
                puts "Es el turno de las #{player.color_spanish}. Para seleccionar tu pieza escribe primero la letra de la columna,"
                puts "luego pulsa enter. A continuación escribe el número de la fila y vuelve a pulsar enter. Para guardar la partida"
                puts "escribe \"S\" y pulsa enter. Para ofrecer tablas escribe \"T\" y pulsa enter."
            end
        else
            if language == "e"
                puts "To move the piece write first the letter column of the square where you want to move it," 
                puts "press enter and then the number of row and press enter again."
            else
                puts "Para mover tu pieza escribe primero la letra de la columna donde la quieras mover, pulsa enter,"
                puts "luego escribe el número de la fila y vuelve a pulsar enter."
            end
        end
        first_input = gets.chomp.downcase
        case 
        when first_input == "s"
            save_game
            return "s"
        when first_input == "t"
            answer = offer_draw(player)
            return answer
        when first_input == "a"
            column = 0
        when first_input == "b"
            column = 1
        when first_input == "c"
            column = 2
        when first_input == "d"
            column = 3
        when first_input == "e"
            column = 4
        when first_input == "f"
            column = 5
        when first_input == "g"
            column = 6
        when first_input == "h"
            column = 7
        end
        second_input = gets.chomp.to_i
        row = 8 - second_input
        return [row, column]
    end

    def is_valid_square?(square, player, piece="")
        if square == "y"
            return true
        elsif square == "s"
            puts "Game saved" if language == "e"
            puts "Partida guardada" if language == "s"
            return false
        elsif piece.class == String ? player.possible_squares.include?(square) : piece.possible_movements.include?(square)
            return true
        else
            puts "This is not a valid square, please select a piece that can move" if language == "e"
            puts "Esta no es una casilla válida, por favor seleccione una pieza que se pueda mover" if language == "s"
            return false
        end
    end


    def game_over_checkmate(player)
        if player.color == "b"
            color_english = "White"
            color_spanish = "blancas"
        else
            color_english = "Black"
            color_spanish = "negras"
        end
        board.display_grid
        puts "#{color_english} is the winner!!!" if language == "e"
        puts "¡¡¡Las #{color_spanish} ganan!!!" if language == "s"
    end

    def game_over_satalemate(player)
        board.display_grid
        puts "It's stalemate, #{player.color_english} cannot move!" if language == "e"
        puts "¡Es tablas por estancamiento, las #{player.color_spanish} no se pueden mover!" if language == "s"
    end

    def save_game
        Dir.mkdir("save") unless Dir.exists?("save")
        File.open("save/save_file.dump",'w') { |f| f.write(YAML.dump(self)) }
    end

    def offer_draw(player)
        puts "#{player.color_english} is offering you a draw, do you accept? (Type \"Y\" to accept or \"N\" to decline)" if language == "e"
        puts "Las #{player.color_spanish} te están ofreciendo tablas, ¿aceptas? (Escribe \"Y\" para aceptar o \"N\" para rechazar)" if language == "s"
        answer = gets.chomp.downcase
        return answer
    end

    def game_over_draw
        board.display_grid
        puts "The game is over, players have agreed to a draw." if language == "e"
        puts "El juego ha terminado, los jugadores han acordado tablas." if language == "s"
    end

end
