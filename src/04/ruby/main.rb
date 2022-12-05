# Solution for Advent of Code 2022 day 4.

class Main

  # Initialize counters
  Integer fully_contain_counter_p1 = 0
  Integer fully_contain_counter_p2 = 0

  file = File.open("input.txt")

  file_data = file.read

  # Loop trough each line
  file_data.each_line do |i|

    # Split string into pieces of numbers
    String numbers = i.split(",")
    String n1 = numbers[0].split("-")
    String n2 = numbers[1].split("-")

    # Convert strings to numbers
    n1[0], n1[1] = n1[0].to_i, n1[1].to_i
    n2[0], n2[1] = n2[0].to_i, n2[1].to_i

    # Part 1
    if (n1[0] <= n2[0] and n1[1] >= n2[1]) or (n2[0] <= n1[0] and n2[1] >= n1[1])
      fully_contain_counter_p1 += 1
    end

    # Part 2 (forgive me pls, this if condition is even more stupid than part 1)
    if (n1[0] <= n2[0] and n2[0] <= n1[1]) or (n1[0] <= n2[1] and n2[1] <= n1[1]) or
      (n2[0] <= n1[0] and n1[0] <= n2[1]) or (n2[0] <= n1[1] and n1[1] <= n2[1])
      fully_contain_counter_p2 += 1
    end

  end

  puts "Part 1: " + fully_contain_counter_p1.to_s
  puts "Part 2: " + fully_contain_counter_p2.to_s

end
