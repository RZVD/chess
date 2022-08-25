# Piece Class. Will be inherited by all other pieces
require_relative 'symbols'

# Base class for all pieces. Also acts as a placeholder for the empty positions in the board for convenience
class Piece
  include Symbols
  attr_accessor :possible_move, :location, :first_move
  attr_reader :color, :en_passant, :castling

  def initialize(location, color = nil)
    @location = location
    @color = color unless color.nil?
    @possible_move = false
    @first_move = false
    @castling = false
  end

  def possible_moves(_grid)
    []
  end

  def can_promote?
    false
  end
end
