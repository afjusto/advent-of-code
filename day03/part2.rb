memory = File.read('input.txt')

regex = /mul\((\d{1,3}),(\d{1,3})\)|don't\(\)|do\(\)/

result = 0
mux_enabled = true

memory.scan(regex) do |a, b|
  if a && b
    result += a.to_i * b.to_i if mux_enabled
  else
    case Regexp.last_match.to_s
    when 'do()'
      mux_enabled = true
    when "don't()"
      mux_enabled = false
    end
  end
end

puts result
