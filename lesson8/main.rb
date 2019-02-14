require_relative './manufacturer'
require_relative './instance_counter'
require_relative './station'
require_relative './passenger_train'
require_relative './cargo_train'
require_relative './route'
require_relative './cargo_carrige'
require_relative './passenger_carrige'

@stations = []
@trains = []
@routes = []

# initial data
5.times do |i|
  train = PassengerTrain.new("pas-#{i}")
  @trains << train
  5.times do |_c|
    number = train.carriges.size + 1
    train.carriges << PassengerCarrige.new(100, number)
  end
  train = CargoTrain.new("car-#{i}")
  @trains << train
  5.times do |_c|
    number = train.carriges.size + 1
    train.carriges << CargoCarrige.new(1000, number)
  end
end

10.times do |s|
  @stations << Station.new("station - #{s}")
  @stations[s].get_train(@trains[s])
end

def show_train_carriges(train = nil)
  if train.nil?
    print_trains
    train = @trains[take_train]
  end
  if train.type == 'Passenger'
    train.each_carrige do |c|
      print "Carrige number - #{c.number} "
      print "passengers - #{c.passengers_count} "
      puts "free seats - #{c.free_seats}"
    end
  else
    train.each_carrige do |c|
      print "Carrige number - #{c.number} "
      print "weight - #{c.weight} "
      puts "remain weight - #{c.remain_weight}"
    end
  end
end

def take_train(train = nil)
  return if @trains.nil?

  print_trains(train)
  print 'Enter train number - '
  gets.to_i
end

def new_station
  print 'Enter station name - '
  name = gets.chomp
  station = Station.new(name)
  @stations << station
  print_stations
rescue StandardError => e
  puts e.message
  retry
end

def new_train
  puts 'Trains types:'
  puts '1 - Paasenger train'
  puts '2 - Cargo train'
  print 'your choice - '
  type = gets.to_i
  print 'Train number - '
  number = gets.chomp
  case type
  when 1
    @trains << PassengerTrain.new(number)
  when 2
    @trains << CargoTrain.new(number)
  end
end

def print_trains(type = nil)
  if type.nil?
    @trains.each_with_index { |val, index| puts "#{index} - #{val.number}" }
  else
    @trains.each_with_index do |val, index|
      puts "#{index} - #{val.number}" if val.type == type
    end
  end
end

def print_stations
  @stations.each_with_index do |val, _index|
    puts "On station #{val.name} the following trains"
    val.each_train do |train|
      puts "Number:#{train.number} - Type:#{train.type} - Carriges:#{train.carriges.count}"
      str = ''
      train.carriges.each do |c|
        str = "Carrige number - #{c.number} carrige type - #{c.class} "
        str += if c.is_a? PassengerCarrige
                 "taken seats - #{c.passengers_count} free seats #{c.free_seats}"
               else
                 "weight - #{c.weight} remain weight - #{c.remain_weight}"
               end
        puts str
      end
    end
  end
end

def new_route
  if @stations.size >= 1
    print 'Route name - '
    name = gets.chomp
    print_stations
    print 'Enter number of begin station - '
    a = gets.to_i
    print 'Enter number of end station - '
    b = gets.to_i
    if @stations[a] && @stations[b]
      route = Route.new(name, @stations[a], @stations[b])
      @routes << route
      puts @routes
    else
      puts 'Enter correct stations'
    end
  else
    puts 'Create stations'
  end
rescue StandardError => e
  puts e.message
  retry
end

def print_routes
  @routes.each_with_index { |val, index| puts "#{index} - #{val.name}" }
end

def add_station
  if @routes.size >= 1
    print_routes
    print 'Chose route - '
    route = gets.to_i
    print_stations
    print 'Enter station number - '
    number = gets.to_i
    if @routes[route] && @stations[number]
      @routes[route].add_station(@stations[number])
    else
      puts 'Enter correct Route or Station'
    end
  else
    puts 'No routes!'
  end
end

def delete_station
  if @routes.size >= 1
    print_routes
    print 'Chose route - '
    route = gets.to_i
    @routes[route].show_route
    print 'Enter station number - '
    number = gets.to_i
    station = @routes[route].stations[number]
    @routes[route].delete_station(station) unless station.nil?
  else
    puts 'No routes!'
  end
end

def add_route_to_train
  print_routes
  print 'Enter route number - '
  route = gets.to_i
  train = take_train
  if train.nil? && @routes[route]
    puts 'No Trains exist or wrong route'
  else
    @trains[train].route = @routes[route]
  end
end

def move_forward
  train = take_train
  if train
    train = @trains[train].move_forward
    puts "train current station - #{train.current_station.name}"
  else
    puts 'Enter correct train'
  end
end

def move_backward
  train = take_train
  if train
    train = @trains[train].move_back
    puts "train current station - #{train.current_station.name}"
  else
    puts 'enter correct train'
  end
end

def add_carrige
  train = @trains[take_train]
  if train && train.type == 'Passenger'
    print 'Enter seats count - '
    count = gets.to_i
    number = train.carriges.size + 1
    train.add_carrige(PassengerCarrige.new(count, number))
  elsif train && train.type == 'Cargo'
    print 'Enter cargage weight - '
    amount = gets.to_i
    number = train.carriges.size + 1
    train.add_carrige(CargoCarrige.new(amount, number))
  else
    puts 'No trains found'
  end
end

def remove_carrige
  train = @trains[take_train]
  train.remove_carrige if train
end

def add_passenger_to_train
  train = take_train('Passenger')
  train = @trains[train]
  show_train_carriges(train)
  print 'Enter carrige number - '
  carrige = gets.to_i
  train.carriges[carrige].add_passenger
end

def add_weight_to_train
  train = take_train('Cargo')
  train = @trains[train]
  show_train_carriges(train)
  print 'Enter carrige number - '
  carrige = gets.to_i
  print 'Enter weight to add -'
  weight = gets.to_i
  train.carriges[carrige].add_weight(weight)
end

loop do
  puts 'Your choice'
  puts '1 - New station'
  puts '2 - New train'
  puts '3 - New Route'
  puts '4 - Add station to route'
  puts '5 - Delete station from route'
  puts '6 - Add route to train'
  puts '7 - Move train forward'
  puts '8 - Move train backward'
  puts '9 - Show trains on station'
  puts '10 - Add carrige to train'
  puts '11 - Remove carrige from train'
  puts '12 - Show train carriges'
  puts '13 - Add passenger'
  puts '14 - add weight'
  puts '15 - exit'
  print 'enter your choice: '
  choice = gets.to_i
  case choice
  when 1
    new_station
  when 2
    new_train
  when 3
    new_route
  when 4
    add_station
  when 5
    delete_station
  when 6
    add_route_to_train
  when 7
    move_forward
  when 8
    move_backward
  when 9
    print_stations
  when 10
    add_carrige
  when 11
    remove_carrige
  when 12
    show_train_carriges
  when 13
    add_passenger_to_train
  when 14
    add_weight_to_train
  when 15
    break
  else
    puts 'Wrong choice'
  end
end

puts 'Bye'
