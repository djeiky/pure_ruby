cart = Hash.new

loop do
  print "Enter product name(or stop to exit) - "
  item_name = gets.chomp
  break if item_name == "stop"
  print "Enter price per item - "
  item_price = gets.chomp.to_f
  print "Enter items count - "
  items_count = gets.chomp.to_i

  cart[item_name] = {'price' => item_price, 'count' => items_count}
end

puts "Name Price Count"
amount = 0
cart.each do |item, details| 
  amount += details['price'] * details['count']
  puts "#{item} #{details['price']} #{details['count']}" 
end

puts "Amount: #{amount}"
