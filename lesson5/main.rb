require_relative "./manufacturer"
require_relative "./instance_counter"
require_relative "./station"
require_relative "./passenger_train"
require_relative "./cargo_train"
require_relative "./route"
require_relative "./cargo_carrige"
require_relative "./passenger_carrige"


@stations = []
@trains = []
@routes = []

def take_train
  if @trains.size >= 0
    print_trains
    print "Enter train number - "
    gets.to_i
  else
    nil
  end
end

def new_station
  print "Enter station name - "
  name = gets.chomp
  station = Station.new(name)
  @stations << station
  print_stations
end

def new_train
  puts "Trains types:"
  puts "1 - Paasenger train"
  puts "2 - Cargo train"
  print "your choice - "
  type = gets.to_i
  print "Train number - "
  number = gets.to_i
  case type
    when 1 
      @trains << PassengerTrain.new(number)
    when 2
      @trains << CargoTrain.new(number)
  end
end

def print_trains
  @trains.each_with_index {|val, index| puts "#{index} - #{val.number}"}
end

def print_stations
  @stations.each_with_index do |val, index| 
    puts "#{index} - #{val.name}"
    val.show_trains
  end
end

def new_route
  if @stations.size >= 1
    print "Route name - "
    name = gets.chomp
    print_stations
    print "Enter number of begin station - "
    a = gets.to_i
    print "Enter number of end station - "
    b = gets.to_i
    if @stations[a] && @stations[b]
      route = Route.new(name, @stations[a], @stations[b])
      @routes << route
      puts @routes
    else
      puts "Enter correct stations"
    end
  else
    puts "Create stations"
  end
end

def print_routes
  @routes.each_with_index { |val, index| puts "#{index} - #{val.name}"}
end

def add_station
  if @routes.size >= 1
    print_routes
    print "Chose route - "
    route = gets.to_i
    print_stations
    print "Enter station number - "
    number = gets.to_i
    if @routes[route] && @stations[number]
      @routes[route].add_station(@stations[number])
    else
      puts "Enter correct Route or Station"
    end
  else
    puts "No routes!"
  end
end

def delete_station
  if @routes.size >= 1
    print_routes
    print "Chose route - "
    route = gets.to_i
    @routes[route].show_route
    print "Enter station number - "
    number = gets.to_i
    station = @routes[route].stations[number]
    @routes[route].delete_station(station)
  else
    puts "No routes!"
  end
end

def add_route_to_train
  print_routes
  print "Enter route number - "
  route = gets.to_i
  train = take_train
  unless train.nil? && @routes[route]
    @trains[train].set_route(@routes[route])
  else
    puts "No Trains exist or wrong route"
  end
end

def move_forward
  train = take_train
  if train
    @trains[train].move_forward
  else
    puts "Enter correct train"
  end
end

def move_backward
  train = take_train
  if train 
    @trains[train].move_back
  else
    puts "enter correct train"
  end
end

def add_carrige
  train = @trains[take_train]

  if train && train.type == 'Passenger'
    train.add_carrige(PassengerCarrige.new)
  elsif train && train.type == 'Cargo'
    train.add_carrige(CargoCarrige.new)
  else
    puts "No trains found"
  end
end

def remove_carrige
  train = @trains[take_train]
  if train
    train.remove_carrige
  end
end

loop do
  puts "Your choice"
  puts "1 - New station"
  puts "2 - New train"
  puts "3 - New Route"
  puts "4 - Add station to route"
  puts "5 - Delete station from route"
  puts "6 - Add route to train"
  puts "7 - Move train forward"
  puts "8 - Move train backward"
  puts "9 - Show trains on station"
  puts "10 - Add carrige to train"
  puts "11 - Remove carrige from train"
  puts "12 - exit"
  print "enter your choice: "
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
      break
    else
      puts "Wrong choice"
  end
end

puts "Bye"
