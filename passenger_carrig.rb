class PassengerCarrig < Carrig
  attr_reader :passenger_capacity

  def initialize(number)
    super(number)
    @occupied_place = 0
    @free_places = 0
    amount_capacity
  end

  def amount_capacity
    @passenger_capacity ||= 0
    puts 'Укажите общее колличество мест в вагоне:'
    @passenger_capacity = gets.chomp.to_i
  end

  def take_places(amount)
    if amount <= @passenger_capacity
      @occupied_place += amount
      @passenger_capacity - @occupied_place
    else
      puts "Вагон может вместить только #{@passenger_capacity}"
    end
  end

  def show_places
    puts "В вагоне зянято #{@occupied_place} мест"
  end

  def show_free_places
    puts "Свободно мест: #{free_places}"
  end

  def to_s
    super + "вместимость: #{@passenger_capacity} человек, зянято #{@occupied_place} мест, свободно мест: #{free_places}"
  end
end
