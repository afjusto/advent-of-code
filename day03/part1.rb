memory = File.read('input.txt')

regex = /mul\((\d{1,3}),(\d{1,3})\)/

result = memory.scan(regex).sum do |a, b|
  a.to_i * b.to_i
end

puts result
