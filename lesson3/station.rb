class Station
  attr_reader :name
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
    train.current_station = self
    puts "Train arrive #{train.number}"
  end

  def send_train(train)
    @trains.delete(train)
    train.current_station = nil
    puts "Train out #{train.number}"
  end

  def show_trains(type = nil)
    @trains.each {|train| puts train.name}
  end
end

class Route
  attr_reader :stations
  
  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station)
    @stations.insert(-2,station)
  end

  def delete_station(station)
    if [@stations.first, @stations.last].include?(station)
      puts "Can't delete begin or end of route!!!"
    else
      @stations.delete(station)
    end
  end

  def show_route
    @stations.each {|station| puts station.name}
  end
end

class Train
  attr_accessor :speed, :current_station
  attr_reader :carriges_count, :route, :number

  def initialize(number, type, carriges_count)
    @number = number
    @type = type
    @speed = 0
    @carriges_count = carriges_count
  end

  def stop
    self.speed = 0
  end

  def add_carrige
    if speed == 0
      @carriges_count += 1
    end
  end

  def remove_carrige
    if speed == 0 && carriges_count > 0
      @carriges_count -= 1
    end
  end

  def set_route(route)
    @route = route
    @current_station = @route.stations.first
  end

  def next_station
    station_index = @route.stations.index(@current_station)
    if station_index >= @route.stations.size - 1
      puts "end of route"
    else
      puts "next station is - #{@route.stations[station_index + 1].name}"
    end
  end

  def previous_station
    station_index = @route.stations.index(@current_station)
    if station_index <= 0 
      puts "begin of route - #{@current_station.name}"
    else
      puts "previous station is - #{@route.stations[station_index - 1].name}"
    end
  end

  def move_forward
    station_index = @route.stations.index(@current_station)
    if station_index >= @route.stations.size - 1
      puts "end of route"
    else
      @current_station = @route.stations[station_index + 1]
    end
  end

  def move_back
    station_index = @route.stations.index(@current_station)
    if station_index <= 0
      puts "begin of route"
    else
      @current_station = @route.stations[station_index - 1]
    end
  end
end


