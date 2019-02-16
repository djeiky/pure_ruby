class Route
  include InstanceCounter
  include Validation

  ROUTE_NAME_REGEX = /^[\d\w]+/i.freeze

  attr_reader :stations, :name

  validate :name, :format, ROUTE_NAME_REGEX
  validate :from, :type, Station
  validate :to, :type, Station

  def initialize(name, from, to)
    @from = from
    @to = to
    @stations = [@from, @to]
    @name = name
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def show_route
    @stations.each_with_index { |station, index| puts "#{index} - #{station.name}" }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
