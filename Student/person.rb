class Person

  attr_reader :git, :id

  def initialize(id: nil, git: nil, phone_number: nil, telegram: nil, email: nil)
    self.id = id if id
    self.git = git if git
  end 

  
  def contact
    raise NotImplementedError, "Метод должен быть реализован в дочернем классе"
  end


  #Фамилия и Инициалы
  def fullname
   raise NotImplementedError, "Метод должен быть реализован в дочернем классе"
  end

  #краткая информация о студенте
  def get_info()  
    "#{fullname()}, #{contact()}, #{@git}"
  end


  def self.valid_id?(id)
    id.match?(/^[0-9]+$/)
  end
  
  def self.valid_git?(git)
    git.match?(/^[A-Za-zА-Яа-яЁё]+$/)
  end 

  def id=(id)
    if self.class.valid_id?(id)
      @id = id
    else 
      raise ArgumentError, 'Invalid id'
    end  
  end 

   def git=(git)
    if self.class.valid_git?(git)
      @git = git
    else 
     raise ArgumentError, 'Invalid git'
    end  
  end 

end