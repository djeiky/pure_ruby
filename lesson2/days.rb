print "Введите день - "
day = gets.to_i
print "Введите месяц - "
month = gets.to_i
print "Введите год - "
year = gets.to_i

#распределение количества дней по месяцам
month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

#определяем високосный год или нет
month_days[1] = 29 if (year % 4 == 0) || (year % 4 == 0 && year % 100 != 0)

puts month_days.take(month - 1).sum + day
