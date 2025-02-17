
require_relative 'person'

class Student<Person

  include Comparable

  attr_reader :birthdate, :surname, :firstname, :lastname, :phone_number, :email, :telegram

  #конструктор класса
  def initialize(id:,surname:,firstname:,lastname:,phone_number:nil,telegram:nil,email:nil,birthdate: nil, git: nil)
    super(id: id, git: git)
    self.surname = surname
    self.firstname = firstname 
    self.lastname = lastname
    self.birthdate = birthdate
  end 

  def fullname
    if @fullname
      @fullname
    else
      "#{@surname} #{@firstname} #{@lastname}"
    end
  end

   #устанавливает значения поля или полей для введенных контактов
  def set_contacts(phone_number: nil, telegram: nil, email: nil)
    self.phone_number = phone_number if phone_number
    self.telegram = telegram if telegram
    self.email = email if email
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
 
    
  def self.from_hash(hash)
    self.new(**hash.transform_keys(&:to_sym))
  end

  # Реализация сравнения студентов по дате рождения
  def <=>(other)
    if other.is_a?(Student)
      self.birthdate <=> other.birthdate
    else
      raise ArgumentError, "Can't compare #{self.class} with #{other.class}"
    end
  end


  def ==(other)
    number_phone == other.number_phone ||
    telegram == other.telegram ||
    email == other.email ||
    git == other.git
  end

  
  def has_contact_and_git?
    has_contact? && has_git?
  end
  
  #Вывод всех данных о студенте на экран
  def to_s
    "\nID: #{@id}\nФИО: #{@surname} #{@firstname} #{@lastname} #{"\nНомер телфона: #{@phone_number}" if @phone_number} #{"\nПочта: #{@email}" if @email} #{"\nТелеграм: #{@telegram}" if @telegram} #{"\nGit: #{@git}" if @git} #{"\nдень рождения: #{@birthdate}"}"
  end  

  #проверка на корректность ФИО

  def self.valid_name?(firstname)
    firstname.match?(/^[A-Za-zА-Яа-яЁё]+$/)
  end 

  def self.birthdate?(birthdate)
    birthdate.match?(/^\d{2}\/\d{2}\/\d{4}$/)
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
 
  def to_h
    { id: self.id, surname: self.surname, firstname: self.firstname, lastname: self.lastname, 
    birthdate: self.birthdate, telegram: self.telegram, email: self.email, phone_number: self.phone_number, git: self.git }
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

    def surname=(surname)
      if self.class.valid_name?(surname)
        @surname = surname
      else 
        raise ArgumentError, 'Invalid surname'
      end  
    end
      
    def firstname=(name)
      if self.class.valid_name?(name) 
        @name=name
      else 
        raise ArgumentError, 'Invalid name'
      end  
    end 

    def lastname=(lastname)
      if self.class.valid_name?(lastname)
        @lastname=lastname
      else 
        raise ArgumentError, 'Invalid patronymic'
      end  
    end  

    def birthdate=(birthdate)
      if self.class.birthdate?(birthdate)
        @birthdate=birthdate
      else 
        raise ArgumentError, 'Invalid birthdate'
      end  
    end  
end
