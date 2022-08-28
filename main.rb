require_relative 'lib/game'

def user_input(game, num)
  if num == 1
    move = game.chess_notation_to_coordinates
    until game.board.piece_at(move).color == game.board.current_turn.downcase
      game.board.draw
      move = game.chess_notation_to_coordinates
    end
    move
  else
    move = game.chess_notation_to_coordinates
    move = game.chess_notation_to_coordinates until game.board.piece_at(move).possible_move || game.board.piece_at(move).castling
    move
  end
end

def play(game)
  until game.over

    game.board.draw
    first_move = user_input(game, 1)
    game.board.query_moves(first_move)

    game.board.draw
    next_move = user_input(game, 2)
    game.board.move(first_move, next_move)
    game.board.draw

    game.over = game.board.mate
  end
end

puts "Play new Human vs Human game (1) or Load Previous game (2)\n Enter 'S' at any time to save the current game"
option = gets.chomp.to_i

if option == 1
  play(Game.new)
else
  play(Game.new.load_game)
end

puts 'Check Mate!'
