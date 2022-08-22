require_relative 'piece'
# Inherits piece.
class Pawn < Piece
  attr_reader :symbol, :color
  attr_accessor :location, :first

  def initialize(location, color)
    super
    @first = true
    @symbol = if color == 'black'
                "\33[30m#{BLACK_PAWN} \33[m"
              else
                "\33[30m#{WHITE_PAWN} \33[m"

              end
  end

  def possible_moves(grid)
    ## TODO : en_passant, capture
    directions = if color == 'black'
                   [[1, 0], [2, 0], [1, 1], [1, -1]]
                 else
                   [[-1, 0], [-2, 0], [-1, 1], [-1, -1]]
                 end

    row = @location[0]
    col = @location[1]

    ans = []

    directions.each_with_index do |direction, i|
      row_offset = direction[0]
      col_offset = direction[1]

      row_check = row_offset + row
      col_check = col_offset + col

      piece_to_capture = grid[row_check][col_check]

      case i
      when 0
        ans << [row_check, col_check] if piece_to_capture.instance_of?(Piece)
      when 1
        ans << [row_check, col_check] if piece_to_capture.instance_of?(Piece) && first
      when 2
        ans << [row_check, col_check] if can_capture?(piece_to_capture) || en_passant?(grid, 'right')
      when 3
        ans << [row_check, col_check] if can_capture?(piece_to_capture) || en_passant?(grid, 'left')
      end
    end
    ans
  end

  def can_capture?(piece_to_capture)
    !piece_to_capture.instance_of?(Piece) && piece_to_capture.color != @color
  end

  def en_passant?(grid, direction)
    row = @location[0]
    col = @location[1]

    if direction == 'right'
      right = col + 1 if (col + 1).between?(0, 7)
      can_capture?(grid[row][right])

    else
      left = col - 1 if (col - 1).between?(0, 7)
      can_capture?(grid[row][left])
    end
  end
end
