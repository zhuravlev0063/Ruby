
require_relative 'person'

class Student<Person

  include Comparable
  attr_accessor :birthdate

  #конструктор класса
  def initialize(id:nil,surname:,firstname:,lastname:,phone_number:nil,telegram:nil,email:nil,git:nil,birthdate: nil)
    super(id: id, git: git,number_phone: phone_number, telegram: telegram, email: email)
    self.surname = surname
    self.firstname = firstname 
    self.lastname = lastname
    self.birthdate = birthdate
  end 

  def has_contact_and_git?
    has_contact? && has_git?
  end

  # Реализация сравнения студентов по дате рождения
  def <=>(other)
    if other.is_a?(Student)
      self.birthdate <=> other.birthdate
    else
      raise ArgumentError, "Can't compare #{self.class} with #{other.class}"
    end
  end

  #Вывод всех данных о студенте на экран
  def to_s
    "\nID: #{@id}\nФИО: #{@surname} #{@name} #{@lastname} #{"\nНомер телфона: #{@number_phone}" if @number_phone} #{"\nПочта: #{@email}" if @email} #{"\nТелеграм: #{@telegram}" if @telegram} #{"\nGit: #{@git}" if @git} #{"\nдень рождения: #{@birthdate}"}"
  end  

  #проверка на корректность ФИО

  def self.valid_name?(name)
    name.match?(/^[A-Za-zА-Яа-яЁё]+$/)
  end 

  def self.birthdate?(birthdate)
    birthdate.match?(/^\d{2}\/\d{2}\/\d{4}$/)
  end 
 
  def to_h
    {
      'id' => self.id,
      'surname' => self.surname,
      'firstname' => self.firstname,
      'lastname' => self.lastname,
      'birthdate' => self.birthdate,
      'phone_number' => self.phone_number,
      'telegram' => self.telegram,
      'email' => self.email,
      'git' => self.git
    }
  end

  private

  def has_contact?
    @email != nil || @telegram != nil || @phone_number != nil
  end
  
  def has_git?
    @git != nil
  end

    def surname=(surname)
      if self.class.valid_name?(surname)
        @surname = surname
      else 
        raise ArgumentError, 'Invalid surname'
      end  
    end
      
    def name=(name)
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
