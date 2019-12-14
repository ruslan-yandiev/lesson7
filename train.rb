class Train
  include TrainCarrige
  include InstanceCounter #Train.include(InstanceCounter)

  attr_reader :carrig, :number

  NUMBER_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i
  NAME_FORMAT = /^[а-яa-z]+\D/i

  def initialize(number)
    @number = number
    @speed = 0
    @route
    @arr_stations = []
    @train_now = nil
    @sum = 0
    @carrig = []
    name_manufacturer!
    validate!
    register_instance
    get!
    show_add_train
  end

  class << self
    def find(number_train)
      puts @train_collection[number_train]
    end

    def get(key, value)
      @train_collection[key] = value
    end
  end

  def carrige_incpect(&block)
    @carrig.each { |carrig| yield(carrig) } if block_given?
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise 'Number can`t be nil' if @number.nil?
    raise 'Name manufacturer can`t be nil' if @name_manufacturer.nil?
    raise 'Name manufacturer can`t be empty string' if @name_manufacturer == ''
    raise 'Number has invalid format' if @number !~ NUMBER_FORMAT
    raise 'Name manufacturer has invalid format' if @name_manufacturer !~ NAME_FORMAT
  end

  def get!
    self.class.get(@number, self)
  end

  def type_train
    self.class
  end

  def speed=(arg)
    @speed = arg if @speed > 0
  end

  def show_speed
    puts @speed
  end

  def start
    @speed = 100
  end

  def stop
    @speed = 0
  end

  def show_add_train
    puts "Создан поезд тип: #{self.class} №#{self.number}, произведен #{self.name_manufacturer}"
  end

  def show_carriages
    puts self
    carrige_incpect { |carrig| puts carrig }
  end

  def to_s
    "Поезд тип: #{self.class} №#{self.number}, произведен #{self.name_manufacturer} присоединено вагонов: #{@carrig.size}"
  end

  def show_route(arg = nil)
    if arg && @route
      @route.show_way(@train_now)
    elsif @route
      @route.show_way
    end
  end

  def add_carrig(carrig)
    if @speed.zero?
      @carrig << carrig
      carrig.change_status(self)
    else
      puts "На ходу нельзя цеплять вагоны!"
    end
  end

  def delete_carrig(carrig = nil)
    if @carrig.size.zero?
      puts "Вагонов уже не осталось."
    elsif carrig.nil? && @speed.zero?
      disconnect_carrig = @carrig.shift
      disconnect_carrig.change_status(self)
    elsif @speed.zero?
      @carrig.delete(carrig)
      carrig.change_status(self)
    else
      puts "На ходу нельзя отцеплять вагоны!"
    end
  end

  def add_route(route_train)
    @route = route_train
    @route.route.each { |x| @arr_stations << x}
    @arr_stations[0].get_train(self)
    @train_now = @arr_stations[0]
  end

  def go
    if @route.nil?
      puts "У поезда нет маршрута следования."
    elsif @sum == @arr_stations.size - 1
      puts 'Поезд находится на конечной станции'
    else
      start
      @sum += 1
      @train_now.send_train(self)
      @arr_stations[@sum].get_train(self)
      @train_now = @arr_stations[@sum]
    end
  end

  def go_back
    if @route.nil?
      puts "У поезда нет маршрута следования."
    elsif @sum == 0
      puts 'Поезд находится на начальной станции'
    else
      start
      @sum -= 1
      @train_now.send_train(self)
      @arr_stations[@sum].get_train(self)
      @train_now = @arr_stations[@sum]
    end
  end

  def show_where
    puts "Поезд находится на станции: #{@train_now.name}" if @route
  end

  #метод защищен так как нельзя стартовать не зная в каком направлении должен двигаться поезд.
  protected :start, :validate!
end
