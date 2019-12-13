module InstanceCounter
  def self.included(arg_class) # InstanceCounter.included(Train)
    arg_class.extend ClassMethods
    arg_class.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    def plus
      @instances ||= 0 #@instances = @instances || 0
      @instances += 1
    end
  end

  module InstanceMethods
    def register_instance
      self.class.plus
    end

    protected :register_instance
  end
end
