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

def has_loop(grid, start_pos, start_direction)
  visited = Set.new
  direction = start_direction
  pos = start_pos

  loop do
    next_pos = get_next_pos(pos, direction)

    return true if visited.include?([next_pos, direction])

    visited << [next_pos, direction]

    if is_valid_pos?(next_pos, grid.size, grid.first.size)
      if grid[next_pos[0]][next_pos[1]] == "#"
        direction = get_next_direction(direction)
      else
        pos = next_pos
      end
    else
      return false
    end
  end
end

input = File.read("input.txt", chomp: true)
grid = input.split("\n").map(&:chars)
cols_count = grid.first.length

start_idx = input.delete("\n").index("^")
start_pos = [start_idx / cols_count, start_idx % cols_count]
start_direction = :up

Set.new([start_pos])

obstacles = Set.new

rows = grid.size
cols = grid.first.size

rows.times do |row|
  cols.times do |col|
    next if grid[row][col] == "#" || [row, col] == start_pos

    grid[row][col] = "#"
    obstacles << [row, col] if has_loop(grid, start_pos, start_direction)
    grid[row][col] = "."
  end
end

p obstacles.size
