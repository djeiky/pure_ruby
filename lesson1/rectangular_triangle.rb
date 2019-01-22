print "Enter side a - "
a = gets.chomp.to_f

print "Enter side b - "
b = gets.chomp.to_f

print "Enter side c - "
c = gets.chomp.to_f
#выявляем гипотенузу и записываем ее в переменную a
if a > b && a < c
  a, c = c, a
elsif b > c
  a, b = b, a
else
  a, c = c, a
end

str = ""

if ( a ** 2 ) == ( b ** 2 + c ** 2)
  str += "rectangular "
else
  str += "not rectangular "
end

if (a == b) && (b == c)
  str += "equilateral "
end

if (a == b) || (b == c) || (a == c)
  str += "isosceles "
end

str += "triangle"

puts str
