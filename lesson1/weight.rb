print "Enter your name - "
name = gets.chomp
name.capitalize!

print "Enter your height - "
height = gets.chomp

optimal_weight = height.to_i - 110

if optimal_weight > 0
  puts "Hi #{name}, your optimal weight is #{optimal_weight}"
else
  puts "Hi #{name}, your weight is optimal"
end
