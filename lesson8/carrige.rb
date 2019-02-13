class Carrige
  include Manufacturer

  attr_reader :type
  attr_accessor :number

  def initialize(type, number)
    @type = type
    @number = number
  end
end
