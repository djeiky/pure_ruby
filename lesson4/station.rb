class Station
  attr_reader :name
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
    train.current_station = self
    puts "Train arrive #{train.number} at station - #{@name}"
  end

  def send_train(train)
    @trains.delete(train)
    train.current_station = nil
    puts "Train out #{train.number}"
  end

  def show_trains(type = nil)
    @trains.each {|train| puts "On station - #{@name} train - #{train.number}"}
  end
end
