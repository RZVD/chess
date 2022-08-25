require_relative 'game'

game = Game.new

until game.over
  game.board.draw
  first_move = game.chess_notation_to_coordinates
  game.board.query_moves(first_move)
  game.board.draw
  next_move = game.chess_notation_to_coordinates
  game.board.move(first_move, next_move)
  game.board.draw
end
