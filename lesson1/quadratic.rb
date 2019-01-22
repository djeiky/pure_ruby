print "enter a - "
a = gets.chomp.to_f

print "enter b - "
b = gets.chomp.to_f

print "enter c - "
c = gets.chomp.to_f

d = b ** 2 - 4 * a * c

if d < 0
  puts "no solution"
elsif d == 0
  x = (- b - Math.sqrt(d)) / ( 2 * a )
  puts "D = " + d.to_s
  puts "X = " + x.to_s
else
  sqrt_d = Math.sqrt(d)
  x1 = (- b - sqrt_d) / ( 2 * a )
  x2 = (- b + sqrt_d) / ( 2 * a )
  puts "D = " + d.to_s
  puts "X1 = " + x1.to_s
  puts "X2 = " + x2.to_s
end
