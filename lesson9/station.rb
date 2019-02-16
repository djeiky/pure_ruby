class Station
  include InstanceCounter
  include Validation

  STATION_NAME_REGEX = /^[\d\w]+/i.freeze

  @@all_stations = []

  attr_reader :name, :trains

  validate :name, :format, STATION_NAME_REGEX

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
  rescue StandardError
    false
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  protected

  attr_writer :trains

  # def validate!
  #  raise 'Invalid station name!' if name !~ STATION_NAME_REGEX
  # end
end
