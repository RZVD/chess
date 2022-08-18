require_relative 'piece'
# Inherits piece.
class Pawn < Piece
  attr_reader :symbol

  def initialize(color)
    @symbol = if color == 'black'
                "\33[30m#{BLACK_PAWN} \33[m"
              else
                "\33[30m#{WHITE_PAWN} \33[m"

              end
  end
end

pawn = Pawn.new('black')
puts pawn.symbol
