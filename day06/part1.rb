def is_valid_pos?(pos, rows, cols)
  row, col = pos
  row.between?(0, rows - 1) && col.between?(0, cols - 1)
end

def get_next_pos(pos, direction)
  row, col = pos
  case direction
  when :up
    [row - 1, col]
  when :down
    [row + 1, col]
  when :left
    [row, col - 1]
  when :right
    [row, col + 1]
  end
end

def get_next_direction(direction)
  directions = [:up, :right, :down, :left]
  directions[(directions.index(direction) + 1) % directions.size]
end

input = File.read("input.txt", chomp: true)
grid = input.split("\n").map(&:chars)
line_length = grid.first.length

position_idx = input.delete("\n").index("^")
position_row = position_idx / line_length
position_col = position_idx % line_length
pos = [position_row, position_col]

visited_cells = Set.new
visited_cells << pos
direction = :up

while true
  next_pos = get_next_pos(pos, direction)

  if is_valid_pos?(next_pos, grid.size, line_length)
    if grid[next_pos[0]][next_pos[1]] == "#"
      direction = get_next_direction(direction)
    else
      pos = next_pos
      visited_cells << pos
    end
  else
    break
  end

end

p visited_cells.size
