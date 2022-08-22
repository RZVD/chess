require_relative 'board'

# Main game class. Also handles IO
class Game
  def initialize
    @board = Board.new
  end

  def chess_notation_to_coordinates
    coord = gets.chomp
    return 'err' if coord.length != 2 || coord[0] > 'h'

    col = coord[0]
    row = coord[1].to_i

    conv = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7
    }
    [8 - row, conv[col]]
  end
end
