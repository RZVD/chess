# Piece Class. Will be inherited by all other pieces
require_relative 'symbols'

class Piece
  include Symbols
  attr_accessor :possible_move

  def initialize
    @possible_move = false
  end
end
