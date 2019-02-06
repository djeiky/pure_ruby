class Route
  include InstanceCounter

  attr_reader :stations, :name
  
  def initialize(name, from, to)
    @stations = [from, to]
    @name = name
    register_instance
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
    @stations.each_with_index {|station, index| puts "#{index} - #{station.name}"}
  end
end

