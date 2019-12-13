class PassengerTrain < Train
  @train_collection = {}

  def add_carrig(carrig)
    if carrig.instance_of? PassengerCarrig
      super
    else
      puts 'Можно присоединить только пассажирские вагоны!'
    end
  end
end


