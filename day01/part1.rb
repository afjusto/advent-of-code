lines = File.readlines('input.txt')

left, right = lines.map { |line| line.split.map(&:to_i) }.transpose.map(&:sort)

sum = left.zip(right).sum { |l, r| (l - r).abs }

puts sum
