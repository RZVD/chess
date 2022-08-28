require_relative 'piece'
# Inherits piece.
class Pawn < Piece
  attr_reader :symbol, :color
  attr_accessor :location, :first_move, :castling

  def initialize(location, color)
    super
    @symbol = if color == 'black'
                "\33[30m#{BLACK_PAWN} \33[m"
              else
                "\33[30m#{WHITE_PAWN} \33[m"

              end
  end

  def possible_moves(grid)
    directions = if color == 'black'
                   [[1, 0], [2, 0], [1, 1], [1, -1]]
                 else
                   [[-1, 0], [-2, 0], [-1, 1], [-1, -1]]
                 end

    row = @location[0]
    col = @location[1]

    ans = []

    blocked = false
    directions.each_with_index do |direction, i|
      row_offset = direction[0]
      col_offset = direction[1]

      row_check = row_offset + row
      col_check = col_offset + col

      next unless row_check.between?(0, 7) && col_check.between?(0, 7)

      piece_to_capture = grid[row_check][col_check]

      case i
      when 0
        piece_to_capture.instance_of?(Piece) ? ans << [row_check, col_check] : blocked = true
      when 1
        ans << [row_check, col_check] if piece_to_capture.instance_of?(Piece) && !first_move && !blocked
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
      right = col + 1
      return unless right.between?(0, 7)

      can_capture?(grid[row][right])
    else
      left = col - 1
      return unless left.between?(0, 7)

      can_capture?(grid[row][left])
    end
  end

  def can_promote?
    @location[0] == if @color == 'black'
                      7
                    else
                      0
                    end
  end
end
