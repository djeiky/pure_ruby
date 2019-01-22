print "Enter your name - "
name = gets.chomp.capitalize

print "Enter your height - "
height = gets.chomp.to_i

optimal_weight = height - 110

if optimal_weight.positive?
  puts "Hi #{name}, your optimal weight is #{optimal_weight}"
else
  puts "Hi #{name}, your weight is optimal"
end
