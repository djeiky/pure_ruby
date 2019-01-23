fibonachi = []
i = 0
loop do
  if i == 0
    next_digit = 0
  elsif i == 1
    next_digit = 1
  else
    next_digit = fibonachi[i-1] + fibonachi[i-2]
  end
  break if (next_digit > 100)
  fibonachi[i] = next_digit
  i += 1
end
puts fibonachi
