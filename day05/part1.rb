ordering_rules, updates = File.read("input.txt").split("\n\n")

rules_map = Hash.new { |hash, key| hash[key] = [] }

ordering_rules.split("\n").map { |line|
  a, b = line.split("|").map(&:to_i)
  rules_map[a] << b
}

sum = 0

updates.split("\n").each { |update|
  pages = update.split(",").map(&:to_i)

  valid_ordering = pages.each_cons(2).all? do |current_page, next_page|
    rules_map[current_page].include?(next_page)
  end

  sum += pages[pages.size / 2] if valid_ordering
}

p sum
