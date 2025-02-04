class Config

  @instance = nil

  attr_accessor :config

  private :config=

  def initialize
    self.config = Hash.new()
  end

  def Config.get_instance
    @instance ||= self.new
  end

  private_class_method :new

  def set_option(option, value)
    self.config[option] = value
  end

  def get_option(option)
    return self.config[option]
  end

end

def main
  config1 = Config.get_instance
  config1.set_option(:status, true)

  p config1

  config2 = Config.get_instance
  config2.set_option(:id, 123)

  p config2

  p config1.object_id, config2.object_id

end

main