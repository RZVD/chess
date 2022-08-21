require 'os'
require_relative 'piece'
require_relative 'pawn'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'queen'
require_relative 'king'
require_relative 'symbols'
class Board
  include Symbols
  def initialize
    @grid = Array.new(8) { Array.new(8) }

    # pawns
    8.times do |i|
      @grid[1][i] = Pawn.new([1, i], 'black')
      @grid[6][i] = Pawn.new([6, i], 'white')
      @grid[2][i] = Piece.new
      @grid[3][i] = Piece.new
      @grid[4][i] = Piece.new
      @grid[5][i] = Piece.new
    end

    # rooks
    @grid[0][0] = Rook.new([0, 0], 'black')
    @grid[0][7] = Rook.new([0, 7], 'black')
    @grid[7][0] = Rook.new([7, 0], 'white')
    @grid[7][7] = Rook.new([7, 7], 'white')

    # knights
    @grid[0][1] = Knight.new([0, 1], 'black')
    @grid[0][6] = Knight.new([0, 6], 'black')
    @grid[7][1] = Knight.new([7, 1], 'white')
    @grid[7][6] = Knight.new([7, 6], 'white')

    # bishops
    @grid[0][2] = Bishop.new([0, 2], 'black')
    @grid[0][5] = Bishop.new([0, 5], 'black')
    @grid[7][2] = Bishop.new([7, 2], 'white')
    @grid[7][5] = Bishop.new([7, 5], 'white')

    # queens
    @grid[0][3] = Queen.new([0, 3], 'black')
    @grid[7][3] = Queen.new([7, 3], 'white')

    # kings
    @grid[0][4] = King.new([0, 4], 'black')
    @grid[7][4] = King.new([7, 4], 'white')
  end

  def draw
    OS.linux? ? system('clear') : system('cls')

    8.times do |i|
      print 8 - i
      8.times do |j|
        square = if @grid[i][j].instance_of?(Piece)
                   if @grid[i][j].possible_move
                     MOVE_DOT
                   else
                     '   '
                   end
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

  def query_moves(location)
    row = location[0]
    col = location[1]

    possible = @grid[row][col].possible_moves(@grid)
    for move in possible do
      row_pos = move[0]
      col_pos = move[1]

      @grid[row_pos][col_pos].possible_move = true if row_pos.between?(0, 7) && col_pos.between?(0, 7)
    end
  end

  def move(initial_location, target_location)
    initial_row = initial_location[0]
    initial_col = initial_location[1]

    target_row = target_location[0]
    target_col = target_location[1]

    return if !initial_row.between?(0, 7) && !initial_col.between?(0, 7) &&
              !target_row.between?(0, 7) && !target_row.between?(0, 7)

    if @grid[target_row][target_col].possible_move == true
      @grid[target_row][target_col], @grid[initial_row][initial_col] =
        @grid[initial_row][initial_col], @grid[target_row][target_col]
    end

    8.times do |i|
      8.times do |j|
        @grid[i][j].possible_move = false
      end
    end
  end
end

board = Board.new
board.query_moves([6, 3])
board.draw
board.move([6, 3], [4, 3])
board.draw

board.query_moves([7, 2])
board.draw
# board.move([6, 2], [4, 2])
# board.draw
