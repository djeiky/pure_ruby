print "enter a - "
a = gets.chomp.to_f

print "enter b - "
b = gets.chomp.to_f

print "enter c - "
c = gets.chomp.to_f

d = b**2 - 4*a*c

if d < 0
  puts "no solution"
elsif d == 0
  X = (Math.sqrt(d) - b)/(2*a)
  puts "D = " + d.to_s
  puts "X = " + X.to_s
else
  X1 = ( 0.0 - Math.sqrt(d) - b)/(2*a)
  X2 = (Math.sqrt(d) - b)/(2*a)
  puts "D = " + d.to_s
  puts "X1 = " + X1.to_s
  puts "X2 = " + X2.to_s
end
