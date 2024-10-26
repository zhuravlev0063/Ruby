# class_person.rb
# Класс Person представляет базовую информацию о человеке и включает в себя валидацию данных.

class Person
  # Определение атрибутов, доступных для чтения и записи
  attr_accessor :id, :surname, :firstname, :lastname
  attr_reader :git, :telegram, :email, :phone_number

  # Инициализация объекта с обязательными параметрами фамилии и имени, остальные параметры опциональны
  def initialize(surname:, firstname:, lastname:, id: nil, phone_number: nil, telegram: nil, email: nil, git: nil)
    @id = id
    self.surname = surname  # Вызов метода surname= для валидации фамилии
    self.firstname = firstname  # Вызов метода firstname= для валидации имени
    self.lastname = lastname  # Вызов метода lastname= для валидации отчества
    self.phone_number = phone_number  # Вызов метода phone_number= для валидации номера телефона
    @telegram = telegram
    self.email = email  # Вызов метода email= для валидации email
    @git = git  # Вызов метода git= для валидации ссылки на Git
  end

  # Сеттер для фамилии с проверкой допустимости значения
  def surname=(surname)
    if self.class.is_name_valid?(surname)
      @surname = surname
    else
      raise ArgumentError.new("Неверная фамилия:\n#{@id}")
    end
  end

  # Сеттер для имени с проверкой допустимости значения
  def firstname=(firstname)
    if self.class.is_name_valid?(firstname)
      @firstname = firstname
    else
      raise ArgumentError.new("Неверное имя:\n#{@id} #{@surname}")
    end
  end

  # Сеттер для отчества с проверкой допустимости значения
  def lastname=(lastname)
    if lastname.empty? || self.class.is_name_valid?(lastname)
      @lastname = lastname
    else
      raise ArgumentError.new("Неверное отчество:\n#{@id} #{@surname} #{@firstname}")
    end
  end

  # Сеттер для номера телефона с проверкой допустимости значения
  def phone_number=(phone_number)
    if phone_number.nil? || self.class.is_phone_number_valid?(phone_number)
      @phone_number = phone_number
    else
      raise ArgumentError.new("Неверный номер телефона:\n#{@id} #{@surname} #{@lastname} #{@firstname}")
    end
  end

  # Сеттер для email с проверкой допустимости значения
  def email=(email)
    if email.nil? || self.class.is_email_valid?(email)
      @email = email
    else
      raise ArgumentError.new("Неверный адрес электронной почты:\n#{@id} #{@surname} #{@lastname} #{@firstname}")
    end
  end

  # Сеттер для Git с проверкой допустимости значения
  def git=(git)
    if git.nil? || self.class.is_git_valid?(git)
      @git = git
    else
      raise ArgumentError.new("Неверный git:\n#{@id} #{@surname} #{@lastname} #{@firstname}")
    end
  end

  # Метод класса для проверки допустимости номера телефона
  def self.is_phone_number_valid?(checked_phone_number)
    phone_number_reg = /^\+?\d{1,3}\s?\(?\s*\d{3}\s*\)?\s?\d{3}-?\d{2}-?\d{2}\s*$/
    !!(checked_phone_number =~ phone_number_reg)
  end

  # Метод класса для проверки допустимости email
  def self.is_email_valid?(checked_email)
    email_reg = /^[A-Za-z0-9._-]+@[A-Za-z0-9._-]+\.[A-Za-z0-9._-]+$/
    !!(checked_email =~ email_reg)
  end

  # Метод класса для проверки допустимости имени
  def self.is_name_valid?(checked_name)
    name_reg = /^[A-Za-zА-яа-я]+$/
    !!(checked_name =~ name_reg)
  end

  # Метод класса для проверки допустимости ссылки на Git
  def self.is_git_valid?(checked_git)
    git_reg = /^(https|http):\/\/github.com\/[A-Za-z0-9._-]+\/?$/
    !!(checked_git =~ git_reg)
  end

  # Метод для получения полного имени в формате "Фамилия Имя Отчество"
  def get_full_name
    "#{@surname} #{@firstname} #{@lastname}"
  end

  # Метод для получения строки с информацией о человеке
  def to_s
    "#{@id} ФИО: #{@surname} #{@firstname} #{@lastname}.\n" \
    "Телефон: #{@phone_number}\n" \
    "Телеграм: #{@telegram}\n" \
    "Email: #{@email}\n" \
    "Git: #{@git}\n\n"
  end
end
