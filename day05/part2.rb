ordering_rules, updates = File.read("input.txt").split("\n\n")

rules_map = Hash.new { |hash, key| hash[key] = [] }
ordering_rules.split("\n").map { |line|
  a, b = line.split("|").map(&:to_i)
  rules_map[a] << b
}

sum = 0

def is_pages_sorted(pages, rules_map)
  pages.each_cons(2).all? do |current_page, next_page|
    rules_map[current_page]&.include?(next_page)
  end
end

def sort_pages(pages, rules_map)
  until is_pages_sorted(pages, rules_map)
    pages.each_cons(2).with_index do |(current_page, next_page), i|
      if !rules_map[current_page]&.include?(next_page)
        tmp = pages[i]
        pages[i] = pages[i + 1]
        pages[i + 1] = tmp
      end
    end
  end

  pages
end

updates.split("\n").each { |update|
  pages = update.split(",").map(&:to_i)

  sorted_pages = nil

  for i in 0..pages.size - 1
    break if !sorted_pages.nil?
    for j in i + 1..pages.size - 1
      current_page = pages[i]
      next_page = pages[j]
      if !rules_map[current_page]&.include?(next_page)
        sorted_pages = sort_pages(pages, rules_map)
        break
      end
    end
  end

  sum += sorted_pages[sorted_pages.size / 2] if !sorted_pages.nil?
}

p sum
