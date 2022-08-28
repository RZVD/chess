require_relative 'game'

# game menu goes here

def play(game)
  until game.over
    game.board.draw
    first_move = game.chess_notation_to_coordinates
    game.board.query_moves(first_move)
    game.board.draw
    next_move = game.chess_notation_to_coordinates
    game.board.move(first_move, next_move)
    game.board.draw
    game.over = game.board.mate
  end
end

puts 'Play new Human vs Human game (1) or Load Previous game (2)'
option = gets.chomp.to_i

if option == 1
  play(Game.new)
else
  play(Game.new.load_game)
end

puts 'Check Mate!'
