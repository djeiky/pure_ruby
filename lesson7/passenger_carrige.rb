require_relative "./carrige"

class PassengerCarrige < Carrige
  
  attr_reader :passengers_count

  def initialize(seats_count, number)
    super('Passenger', number)
    @seats_count = seats_count
    @passengers_count = 0
  end

  def add_passenger
    if @passengers_count < @seats_count
      @passengers_count += 1
    else
      nil
    end
  end

  def free_seats
    @seats_count - @passengers_count
  end
private
  attr_accessor :seats_count
  attr_writer :passengers_count
end

