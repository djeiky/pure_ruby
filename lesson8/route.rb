class Route
  include InstanceCounter

  ROUTE_NAME_REGEX = /^[\d\w]+/i.freeze

  attr_reader :stations, :name

  def initialize(name, from, to)
    @stations = [from, to]
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

  protected

  def validate!
    raise 'Invalid route name!!' if name !~ ROUTE_NAME_REGEX
    raise 'Invalid stations count in route!' if @stations.size < 2
    raise 'Invalid stations' unless @stations.each { |s| s.is_a? Station }
  end
end
