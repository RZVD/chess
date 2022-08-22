# Piece Class. Will be inherited by all other pieces
require_relative 'symbols'

# Base class for all pieces. Also acts as a placeholder for the empty positions in the board for convenience
class Piece
  include Symbols
  attr_accessor :possible_move

  def initialize(location, _color = nil)
    @location = location
    @possible_move = false
  end
end
