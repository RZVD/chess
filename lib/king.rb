require_relative 'piece'
# Inherits piece.
class King < Piece
  attr_reader :symbol, :color
  attr_accessor :location

  def initialize(location, color)
    super
    @symbol = if color == 'black'
                "\33[30m#{BLACK_KING} \33[m"
              else
                "\33[30m#{WHITE_KING} \33[m"
              end
  end

  def possible_moves
    [
      [1, 1], [1, -1], [-1, 1], [-1, -1],
      [1, 0], [0, 1], [-1, 0], [0, -1]
    ]
  end
end
