lines = File.readlines("input.txt", chomp: true)

OPERATORS = ["+", "*", "||"]

def eval(numbers, operators)
  result = numbers[0]
  numbers[1..].each_with_index do |num, i|
    case operators[i]
    when "+"
      result += num
    when "*"
      result *= num
    when "||"
      result = (result.to_s + num.to_s).to_i
    end
  end
  result
end

total_calibration = lines.sum do |line|
  total, numbers = line.split(":")
  total = total.to_i
  numbers = numbers.split.map(&:to_i)

  combinations = OPERATORS.repeated_permutation(numbers.size).to_a

  valid = combinations.any? do |op|
    eval(numbers, op) == total
  end

  valid ? total : 0
end

p total_calibration
