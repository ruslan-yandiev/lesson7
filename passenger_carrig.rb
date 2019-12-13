class PassengerCarrig < Carrig
  attr_reader :passenger_capacity

  def initialize(number)
    super(number)
    @occupied_place = 0
    amount_capacity
  end

  def amount_capacity
    @passenger_capacity ||= 0
    puts 'Укажите общее колличество мест в вагоне:'
    @passenger_capacity = gets.chomp.to_i
  end

  def take_places(amount)
    @occupied_place += amount
  end

  def show_places
    puts "В вагоне зянято #{@occupied_place} мест"
  end

  def show_free_places
    puts "Свободно мест: #{@passenger_capacity - @occupied_place}"
  end

  def to_s
    super + "вместимость: #{@passenger_capacity} человек"
  end
end
