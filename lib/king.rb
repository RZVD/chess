require_relative 'piece'
# Inherits piece.
class King < Piece
  attr_reader :symbol

  def initialize(color)
    @symbol = if color == 'black'
                "\33[30m#{BLACK_KING} \33[m"
              else
                "\33[30m#{WHITE_KING} \33[m"
              end
  end
end
