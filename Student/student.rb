
require_relative 'person'

class Student<Person

  include Comparable

  attr_accessor :birthdate, :surname, :firstname, :lastname
  attr_reader :phone_number, :email, :telegram, :unique_indicator

  #конструктор класса
  def initialize(id:nil,surname:,firstname:,lastname:,phone_number:nil,telegram:nil,email:nil,git:nil,birthdate: nil,, unique_indicator: :git)
    super(id: id, git: git,phone_number: phone_number, telegram: telegram, email: email)
    self.surname = surname
    self.firstname = firstname 
    self.lastname = lastname
    self.birthdate = birthdate
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
 
  def to_h
    { id: self.id, surname: self.surname, firstname: self.firstname, lastname: self.lastname, 
    birthdate: self.birthdate, telegram: self.telegram, email: self.email, phone_number: self.phone_number, git: self.git }
  end

  private

  attr_writer :unique_indicator

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
