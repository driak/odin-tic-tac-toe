# frozen_string_literal: true

grid = [
         ['', '', ''],
         ['', '', ''],
         ['', '', '']
       ]

grid.each { |row| p row }

def columns(grid)
  columns = []

  3.times do |index|
    columns << grid.map { |row| row[index] }
  end

  columns
end

def rows(grid)
  grid
end

def flip(grid)
  grid.map(&:reverse)
end

def diagonals(grid)
  left_diagonal = []
  right_diagonal = []

  3.times do |index|
    left_diagonal << rows(grid)[index][index]
    right_diagonal << rows(flip(grid))[index][index]
  end

  [left_diagonal, right_diagonal]
end

def triple_succession?(array)
  array.all? { |marker| marker == 'x' } ||
    array.all? { |marker| marker == 'o' }
end

def vertical_triple_succession?(grid)
  columns(grid).one? { |column| triple_succession?(column) }
end

def horizontal_triple_succession?(grid)
  rows(grid).one? { |row| triple_succession?(row) }
end

def diagonal_triple_succession?(grid)
  diagonals(grid).one? { |diagonal| triple_succession?(diagonal) }
end

def same_successive_triple_marker?(grid)
  vertical_triple_succession?(grid)   ||
  horizontal_triple_succession?(grid) ||
  diagonal_triple_succession?(grid)
end

def win?(grid)
  same_successive_triple_marker?(grid)
end

turn_count = 0

until win?(grid)
  marker = turn_count.even? ? 'x' : 'o'
  indices = ''
  loop do
    puts 'input row and column index consecutively (for example 02 -- here, 0 is the row index, 2 is the column index)'
    input = gets.chomp.chars.map(&:to_i)

    if input.length == 2 && input.all? { |char| (0..2).include?(char) } && grid[input[0]][input[1]] == ''
      indices = input
      break
    end
  end

  row_index, column_index = indices
  grid[row_index][column_index] = marker

  grid.each { |row| p row }

  turn_count += 1
end
