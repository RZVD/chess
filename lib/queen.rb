require_relative 'piece'
# Inherits piece.
class Queen < Piece
  attr_reader :symbol

  def initialize(color)
    @symbol = if color == 'black'
                "\33[30m#{BLACK_QUEEN} \33[m"
              else
                "\33[30m#{WHITE_QUEEN} \33[m"
              end
  end
end
