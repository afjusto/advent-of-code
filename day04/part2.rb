grid = File.read('input.txt', chomp: true).split("\n").map(&:chars)
line_length = grid[0].length
count = 0

def is_match?(word)
  word == 'MAS' || word == 'SAM'
end

grid.each_with_index do |row, row_idx|
  row.each_with_index do |_, col_idx|

    next if row_idx < 1 || row_idx >= grid.size - 1
    next if col_idx < 1 || col_idx >= line_length - 1

    d1 = [
      grid[row_idx - 1][col_idx - 1],
      grid[row_idx][col_idx],
      grid[row_idx + 1][col_idx + 1],
    ].join

    d2 = [
      grid[row_idx + 1][col_idx - 1],
      grid[row_idx][col_idx],
      grid[row_idx - 1][col_idx + 1],
    ].join

    count += 1 if is_match?(d1) && is_match?(d2)
  end
end

puts count
