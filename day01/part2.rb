lines = File.readlines('input.txt')

left, right = lines.map { |line| line.split.map(&:to_i) }.transpose

score = left.sum { |l| l * right.count(l) }

puts score

# Notes: tally could be used to create a hash of the counts of each element in the array
# instead of using the count method. This would be more efficient.
