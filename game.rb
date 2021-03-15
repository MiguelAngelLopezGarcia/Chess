require "./board.rb"

class Game
    def start_game
        player_one = Player.new("w", "white")
        player_two = Player.new("b", "black")
        board = Board.new
        board.insert_pieces
        board.display_clear_grid
        play_game(player_one, player_two, board)
    end

    def play_game(player_one, player_two, board)
        player_verification = "w"
        until board.is_mate?(player_one)
            play_round(board, player_one)
            if board.is_mate?(player_two)
                player_verification = "b"
                break
            end
            play_round(board, player_two)
        end
        if player_verification == "w"
            player = player_one
        else
            player = player_two
        end
        if board.is_in_check?(player)
            game_over_checkmate(player)
        else
            game_over_satalemate(player)
        end
    end

    def play_round(board, player)
        square_from = get_square(player, 1)
        until player.possible_squares.include?(square_from)
            puts "This square it's not valid, please select a valid piece to move."
            square_from = get_square(player, 1)
        end
        selected_piece = board.create_piece_class(square_from)
        selected_piece.select_piece(board.grid, square_from, player)
        board.display_grid
        square_to = get_square(player, 2)
        until selected_piece.possible_movements.include?(square_to)
            puts "This square it's not valid to move, please select a valid square (marked with red dot)."
            square_to = get_square(player, 2)
        end
        selected_piece.move_to(board.grid, square_from, square_to)
        board.display_clear_grid
        board.am_i_checking(player)
        board.display_grid
    end
    
    def get_square(player, number)
        if number == 1
            puts "It's #{player.full_color}'s turn. To select your piece write the letter of the column," 
            puts "press enter and then the number of the row and press enter again."
        else
            puts "To move the piece write first the letter column of the square where you want to move it," 
            puts "press enter and then the number of row and press enter again."
        end
        first_input = gets.chomp.downcase
        second_input = gets.chomp
        case 
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
        case 
        when second_input == "1"
            row = 7
        when second_input == "2"
            row = 6
        when second_input == "3"
            row = 5
        when second_input == "4"
            row = 4
        when second_input == "5"
            row = 3
        when second_input == "6"
            row = 2
        when second_input == "7"
            row = 1
        when second_input == "8"
            row = 0
        end
        return [row, column]
    end

    def game_over_checkmate(player)
        if player.color == "b"
            color = "White"
        else
            color = "Black"
        end
        puts "#{color} is the winner!!!"
    end

    def game_over_satalemate(player)
        puts "It's stalemate, #{player.full_color} cannot move!"
    end

end
