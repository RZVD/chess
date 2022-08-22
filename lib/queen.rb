require_relative 'piece'
# Inherits piece.
class Queen < Piece
  attr_reader :symbol, :color
  attr_accessor :location

  def initialize(location, color)
    super
    @symbol = if color == 'black'
                "\33[30m#{BLACK_QUEEN} \33[m"
              else
                "\33[30m#{WHITE_QUEEN} \33[m"
              end
  end

  def possible_moves(grid)
    row = @location[0]
    col = @location[1]

    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1],
                  [1, 0], [0, 1], [-1, 0], [0, -1]]
    ans = []

    directions.each do |direction|
      row_offset = direction[0]
      col_offset = direction[1]

      row_check = row + row_offset
      col_check = col + col_offset

      while row_check.between?(0, 7) && col_check.between?(0, 7)
        break if grid[row_check][col_check].class != Piece

        ans << [row_check, col_check]
        row_check += row_offset
        col_check += col_offset
      end
    end

    ans
  end
end
