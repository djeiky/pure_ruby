step_array1 = (10..100).step(5).to_a
print step_array1

step_array2 = []
i = 10
loop do
  break if i > 100
  step_array2 << i
  i += 5
end
print step_array2
