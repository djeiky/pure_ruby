class Train
  include Manufacturer
  include InstanceCounter

  TRAIN_NUMBER_REGEX = /^[\d\w]{3}-?[\d\w]{2}$/i

  attr_accessor :speed, :current_station, :number, :carriges, :type
  attr_reader :route

  @@all_trains = {}

  def initialize(number, type)
    @number = number
    @speed = 0
    @type = type
    @carriges = []
    @@all_trains[@number] = self
    validate!
    register_instance
  end

  def self.find(number)
    @@all_trains[number]
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
      @current_station
    else
      @route.stations[station_index + 1]
    end
  end

  def previous_station
    station_index = @route.stations.index(@current_station)
    if station_index <= 0 
      @current_station
    else
      @route.stations[station_index - 1]
    end
  end

  def move_forward
    station_index = @route.stations.index(@current_station)
    return self if station_index >= @route.stations.size - 1
   
    @current_station.send_train(self)
    @current_station = @route.stations[station_index + 1]
    @current_station.get_train(self)
  end

  def move_back
    station_index = @route.stations.index(@current_station)
    return self  if station_index <= 0
    
    @current_station.send_train(self)
    @current_station = @route.stations[station_index - 1]
    @current_station.get_train(self)
  end

  def validate?
    validate!
    true
  rescue
    false
  end

protected

  def validate!
    raise "Invalid train number!" if number !~ TRAIN_NUMBER_REGEX
    raise "Invalid type of train" if type.nil?
  end
end

