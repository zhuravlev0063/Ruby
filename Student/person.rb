class Person

  attr_reader :git, :id

  def initialize(id: nil, git: nil, phone_number: nil, telegram: nil, email: nil)
    self.id = id if id
    self.git = git if git
    set_contacts(phone_number: phone_number, telegram: telegram, email: email)
  end 

  
  def contact
    if @contact.nil?
      contacts={'номер телефона: ': @phone_number, 'почта: ': @email, 'Телеграм:': @telegram}
      contact=nil
      contacts.each do |key,value|
        if !value.nil?
          contact= "#{key}#{value}"
          break
        end  
      end
      contact
    else
      contact = @contact
      contact
    end
  end

    #устанавливает значения поля или полей для введенных контактов
  def set_contacts(phone_number: nil, telegram: nil, email: nil)
    self.phone_number = phone_number if phone_number
    self.telegram = telegram if telegram
    self.email = email if email
  end 
    
  #Фамилия и Инициалы
  def fullname
    if @fullname
      @fullname
    else
      "#{@surname} #{@firstname} #{@lastname}"
    end
  end

  def has_contact_and_git?
    has_contact? && has_git?
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

  def self.valid_number?(phone_number)
    phone_number.match?(/^\d{11}$/)
  end
  
  def self.valid_telegram?(telegram)
    telegram.match?(/^[A-Za-zА-Яа-яЁё]+$/)
  end 
 
  def self.valid_email?(email)
    email.match?(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}+$/)
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

  private

  def has_contact?
    @email != nil || @telegram != nil || @phone_number != nil
  end
  
  def has_git?
    @git != nil
  end

  def phone_number=(phone_number)
    if self.class.valid_number?(phone_number)
      @phone_number = phone_number
    else 
     raise ArgumentError, 'Invalid phone_number'
    end  
  end  

   def telegram=(telegram)
    if self.class.valid_telegram?(telegram)
      @telegram = telegram
    else 
      raise ArgumentError, 'Invalid telegram'
    end  
  end  
 
   def email=(email)
    if self.class.valid_email?(email)
      @email = email
    else 
      raise ArgumentError, 'Invalid email'
    end  
  end
end