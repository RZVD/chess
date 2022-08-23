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
      @grid[2][i] = Piece.new([2, i])
      @grid[3][i] = Piece.new([3, i])
      @grid[4][i] = Piece.new([4, i])
      @grid[5][i] = Piece.new([5, i])
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

        if @grid[i][j].possible_move && !@grid[i][j].instance_of?(Piece)
          print "\33[41m#{square}\33[m"
        elsif (i + j).even?
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
    possible.each do |position|
      row_pos = position[0]
      col_pos = position[1]

      @grid[row_pos][col_pos].possible_move = true if row_pos.between?(0, 7) && col_pos.between?(0, 7)
    end
  end

  def move(initial_location, target_location)
    initial_row = initial_location[0]
    initial_col = initial_location[1]

    target_row = target_location[0]
    target_col = target_location[1]

    already_captured = false
    return if !initial_row.between?(0, 7) && !initial_col.between?(0, 7) &&
              !target_row.between?(0, 7) && !target_row.between?(0, 7)

    return if @grid[target_row][target_col].possible_move == false

    if @grid[target_row][target_col].possible_move == true

      if @grid[target_row][target_col].instance_of?(Piece)
        # swap positions
        @grid[target_row][target_col], @grid[initial_row][initial_col] =
          @grid[initial_row][initial_col], @grid[target_row][target_col]

        # update swapped piece's position
        @grid[initial_row][initial_col].location = [initial_row, initial_col]

      elsif @grid[target_row][target_col].color != @grid[initial_row][initial_col].color
        # remove captured piece
        @grid[target_row][target_col] = @grid[initial_row][initial_col]
        @grid[initial_row][initial_col] = Piece.new([initial_row, target_row])
        already_captured = true
      end

    end

    # update location
    @grid[target_row][target_col].location = [target_row, target_col]

    @grid[target_row][target_col].first_move = true

    # promote to queen
    if @grid[target_row][target_col].instance_of?(Pawn) & @grid[target_row][target_col].can_promote?
      @grid[target_row][target_col] = Queen.new([target_row, target_col], @grid[target_row][target_col].color)
    end

    # en passant
    if @grid[target_row][target_col].instance_of?(Pawn)
      behind = if @grid[target_row][target_col].color == 'black'
                 target_row - 1
               else
                 target_row + 1
               end
      unless @grid[behind][target_col].instance_of?(Piece) || already_captured
        @grid[behind][target_col] = Piece.new([behind, target_col])
      end
    end

    8.times do |i|
      8.times do |j|
        @grid[i][j].possible_move = false
      end
    end
  end
end
