lines = File.readlines('input.txt')

def level_safe?(levels)
  differences = levels.each_cons(2).map { |a, b| b - a }

  same_trend = differences.all?(&:positive?) || differences.all?(&:negative?)
  valid_differences = differences.all? { |diff| diff.abs >= 1 && diff.abs <= 3 }

  same_trend && valid_differences
end

safe_reports = lines.count do |line|
  levels = line.split.map(&:to_i)

  level_safe?(levels)
end

puts safe_reports
