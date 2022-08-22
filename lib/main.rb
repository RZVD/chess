require_relative 'game'

game = Game.new

until game.over
  game.board.draw
  querry_move = game.chess_notation_to_coordinates
  game.board.query_moves(querry_move)
  game.board.draw
  next_move = game.chess_notation_to_coordinates
  game.board.move(querry_move, next_move)
  game.board.draw
end
