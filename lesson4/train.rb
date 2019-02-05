class Train
  attr_accessor :speed, :current_station, :number, :carriges, :type
  attr_reader :route

  def initialize(number)
    @number = number
    @speed = 0
    @carriges = []
  end

  def stop
    @speed = 0
  end

  def add_carrige(carrige)
    if @speed == 0 && carrige.type == self.type
      @carriges << carrige
    end
  end

  def remove_carrige
    if @speed == 0 && @carriges.size > 0
      @carriges.pop
    end
  end

  def set_route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.get_train(self)
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
      @current_station.get_train(self)
    end
  end

  def move_back
    station_index = @route.stations.index(@current_station)
    if station_index <= 0
      puts "begin of route"
    else
      @current_station = @route.stations[station_index - 1]
      @current_station.get_train(self)
    end
  end
end

