require_relative 'board'

# Main game class. Also handles IO
class Game
  attr_reader :board
  attr_accessor :over

  def initialize
    @over = false
    @board = Board.new
  end

  def chess_notation_to_coordinates
    coord = gets.chomp
    coord = gets.chomp until valid_input?(coord)

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

  def valid_input?(str)
    str.length == 2 && str[0].between?('a', 'h') && str[1].to_i.between?(0, 8)
  end
end
