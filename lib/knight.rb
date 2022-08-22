require_relative 'piece'
# Inherits piece.
class Knight < Piece
  attr_reader :symbol
  attr_accessor :location, :color

  def initialize(location, color)
    @location = location
    @color = color
    @symbol = if color == 'black'
                "\33[30m#{BLACK_KNIGHT} \33[m"
              else
                "\33[30m#{WHITE_KNIGHT} \33[m"
              end
  end

  def possible_moves(_grid)
    row = @location[0]
    col = @location[1]

    directions = [
      [2, 1], [2, -1], [-2, 1], [-2, -1],
      [1, 2], [-1, 2], [1, -2], [-1, -2]
    ]
    ans = []

    directions.each do |direction|
      row_offset = direction[0]
      col_offset = direction[1]

      row_check = row + row_offset
      col_check = col + col_offset

      ans << [row_check, col_check]
    end
    ans
  end
end
