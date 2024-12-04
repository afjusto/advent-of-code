grid = File.read('input.txt', chomp: true).split("\n").map(&:chars)
line_length = grid[0].length
count = 0

def is_match?(word)
  word == 'XMAS' || word == 'SAMX'
end

grid.each_with_index do |row, row_idx|
  row.each_with_index do |_, col_idx|
    if col_idx <= line_length - 4
      horizontal = grid[row_idx][col_idx, 4].join
      count += 1 if is_match?(horizontal)
    end

    if row_idx <= grid.size - 4
      vertical = (0..3).map { |i| grid[row_idx + i][col_idx] }.join
      count += 1 if is_match?(vertical)
    end

    if row_idx <= grid.size - 4 && col_idx <= line_length - 4
      diagonal_right = (0..3).map { |i| grid[row_idx + i][col_idx + i] }.join
      count += 1 if is_match?(diagonal_right)
    end

    if row_idx <= grid.size - 4 && col_idx >= 3
      diagonal_left = (0..3).map { |i| grid[row_idx + i][col_idx - i] }.join
      count += 1 if is_match?(diagonal_left)
    end
  end
end

puts count
