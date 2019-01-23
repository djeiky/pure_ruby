fibonachi = [0, 1]
i = 2
loop do
  next_digit = fibonachi[i-1] + fibonachi[i-2]
  break if (next_digit > 100)
  fibonachi[i] = next_digit
  i += 1
end

puts fibonachi
