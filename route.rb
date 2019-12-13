class Route
  include InstanceCounter

  attr_accessor :route, :name

  NAME = /^[а-яa-z]+\D/i

  def initialize(name)
    @name = name
    @route = []
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise 'Name can`t be nil' if @name.nil?
    raise 'Name can`t be empty string' if @name == ''
    raise 'Name has invalid format' if @name !~ NAME
  end

  def add_stations(new_route)
    @route << new_route
  end

  def delete_way(index)
    @route.delete_at(index)
  end

  def show_way(name_station = nil)
    if name_station
      num = @route.index(name_station)
      puts "Вы покинули станцию #{@route[num -1].name},\nСейчас находитесь на станции #{@route[num].name}\nСледующая остановка #{@route[num + 1].name}"
    else
      @route.each { |x| puts x.name }
    end
  end

  protected :validate!
end
