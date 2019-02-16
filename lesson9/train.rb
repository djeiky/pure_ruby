class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  TRAIN_NUMBER_REGEX = /^[\d\w]{3}-?[\d\w]+$/i.freeze

  @@all_trains = {}

  attr_accessor :current_station, :carriges, :type
  attr_reader :route

  attr_accessor_with_history :speed

  strong_attr_accessor :number, String

  validate :type, :presence
  validate :number, :type, String
  validate :number, :format, TRAIN_NUMBER_REGEX

  def initialize(number, type)
    self.number = number
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
    return unless @speed.zero? && carrige.type == type

    carrige.number = @carriges.size + 1
    @carriges << carrige
  end

  def remove_carrige
    @carriges.pop if @speed.zero? && !@carriges.empty?
  end

  def route=(route)
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

  def each_carrige
    @carriges.each { |c| yield(c) }
  end
end
