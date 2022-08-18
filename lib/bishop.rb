require_relative 'piece'
# Inherits piece.
class Bishop < Piece
  attr_reader :symbol

  def initialize(color)
    @symbol = if color == 'black'
                "\33[30m#{BLACK_BISHOP} \33[m"
              else
                "\33[30m#{WHITE_BISHOP} \33[m"
              end
  end
end
