print "Введите день - "
day = gets.chomp.to_i
print "Введите месяц - "
month = gets.chomp.to_i
print "Введите год - "
year = gets.chomp.to_i

#распределение количества дней по месяцам
month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

#определяем високосный год или нет
month_days[1] = 29 if (year % 4 == 0) || (year % 4 == 0 && year % 100 != 0)

sum = 0
month_days[0..month - 2].each do |m|
  sum += m
end

sum += day

puts sum
