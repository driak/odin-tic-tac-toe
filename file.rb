# frozen_string_literal: true

grid = [
         ['o', '', ''],
         ['', 'o', ''],
         ['', '', 'o']
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
    right_diagonal << flip(grid)[index][index]
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

puts same_successive_triple_marker?(grid)
