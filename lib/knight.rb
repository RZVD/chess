require_relative 'piece'
# Inherits piece.
class Knight < Piece
  attr_reader :symbol

  def initialize(color)
    @symbol = if color == 'black'
                "\33[30m#{BLACK_KNIGHT} \33[m"
              else
                "\33[30m#{WHITE_KNIGHT} \33[m"
              end
  end
end
