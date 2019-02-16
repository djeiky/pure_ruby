require_relative './train'

class CargoTrain < Train
  validate :type, :presence
  validate :number, :type, String
  validate :number, :format, TRAIN_NUMBER_REGEX

  def initialize(number)
    super(number, 'Cargo')
  end
end
