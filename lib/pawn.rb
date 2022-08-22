require_relative 'piece'
# Inherits piece.
class Pawn < Piece
  attr_reader :symbol, :color
  attr_accessor :location

  def initialize(location, color)
    super
    @symbol = if color == 'black'
                "\33[30m#{BLACK_PAWN} \33[m"
              else
                "\33[30m#{WHITE_PAWN} \33[m"

              end
  end

  def possible_moves(_grid)
    row = @location[0]
    col = @location[1]

    ans = []

    ans << if @color == 'black'
             [row + 1, col]
           else
             [row - 1, col]
           end

    if @color == 'black' && row == 1
      ans << [row + 2, col]
    elsif row == 6
      ans << [row - 2, col]
    end
  end
end
