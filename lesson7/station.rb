class Station
  include InstanceCounter

  STATION_NAME_REGEX = /^[\d\w]+/i

  attr_reader :name,:trains
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    validate!
    register_instance
 end

  def self.all
    @@all_stations
  end

  def get_train(train)
    trains << train
    train
  end

  def send_train(train)
    trains.delete(train)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def show_trains
    @trains.each { |train| yield(train) }
  end

protected
  attr_writer :trains

  def validate!
    raise "Invalid station name!" if name !~ STATION_NAME_REGEX
  end
end
