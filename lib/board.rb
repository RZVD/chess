require 'os'
require_relative 'pawn'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'queen'
require_relative 'king'
class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }

    # pawns
    8.times do |i|
      @grid[1][i] = Pawn.new('black')
      @grid[6][i] = Pawn.new('white')
    end
    # rooks
    @grid[0][0] = Rook.new('black')
    @grid[0][7] = Rook.new('black')
    @grid[7][0] = Rook.new('white')
    @grid[7][7] = Rook.new('white')

    # knights
    @grid[0][1] = Knight.new('black')
    @grid[0][6] = Knight.new('black')
    @grid[7][1] = Knight.new('white')
    @grid[7][6] = Knight.new('white')

    # bishops
    @grid[0][2] = Bishop.new('black')
    @grid[0][5] = Bishop.new('black')
    @grid[7][2] = Bishop.new('white')
    @grid[7][5] = Bishop.new('white')

    # queens
    @grid[0][3] = Queen.new('black')
    @grid[7][3] = Queen.new('white')

    # kings
    @grid[0][4] = King.new('black')
    @grid[7][4] = King.new('white')
  end

  def draw
    OS.linux? ? system('clear') : system('cls')

    8.times do |i|
      print 8 - i
      8.times do |j|
        square = if @grid[i][j].nil?
                   '   '
                 else
                   " #{@grid[i][j].symbol}"
                 end

        if (i + j).even?
          print "\33[47m#{square}\33[m"
        else
          print "\33[44m#{square}\33[m"
        end
      end
      puts
    end
    puts '  a  b  c  d  e  f  g  h'
  end
end

board = Board.new
board.draw
