class Student
  # Автоматическое создание геттеров для всех полей
  attr_accessor :id, :telegram
  attr_reader :surname, :firstname, :lastname, :telegram, :email, :git, :phone_number

  # Конструктор
  def initialize(surname, firstname, lastname, id: nil, phone_number: nil, telegram: nil, email: nil, git: nil)
    self.surname = surname
    self.firstname = firstname
    self.lastname = lastname
    @id = id
    self.phone_number = phone_number
    self.telegram = telegram
    self.email = email
    self.git = git
  end

  # Метод для общей проверки валидности
  def self.validate_field(value, regex, error_message)
    return value if value.nil? || value =~ regex

    raise ArgumentError.new(error_message)
  end

  # Валидация фамилии
  def surname=(surname)
    @surname = Student.validate_field(surname, /^[A-Za-zА-яа-я]+$/, "Неверная фамилия студента: #{@id}")
  end

  # Валидация имени
  def firstname=(firstname)
    @firstname = Student.validate_field(firstname, /^[A-Za-zА-яа-я]+$/, "Неверное имя студента: #{@id} #{@surname}")
  end

  # Валидация отчества
  def lastname=(lastname)
    @lastname = Student.validate_field(lastname, /^[A-Za-zА-яа-я]+$/, "Неверное отчество студента: #{@id} #{@surname} #{@firstname}")
  end

  # Валидация номера телефона
  def phone_number=(phone_number)
    phone_number_reg = /^\+?\d{1,3}\s?\(?\d{3}\)?\s?\d{3}-?\d{2}-?\d{2}$/
    @phone_number = Student.validate_field(phone_number, phone_number_reg, "Неверный номер телефона для студента: #{@id} #{@surname} #{@lastname} #{@firstname}")
  end

  # Валидация email
  def email=(email)
    email_reg = /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i
    @email = Student.validate_field(email, email_reg, "Неверный адрес электронной почты: #{@id} #{@surname} #{@lastname} #{@firstname}")
  end

  # Валидация git
  def git=(git)
    git_reg = /^https:\/\/github\.com\/[A-Za-z0-9._-]+\/?$/
    @git = Student.validate_field(git, git_reg, "Неверная ссылка Git: #{@id} #{@surname} #{@lastname} #{@firstname}")
  end

  # Валидация Telegram handle
  def telegram=(telegram)
    telegram_reg = /^@[a-zA-Z0-9_]{5,}$/
    @telegram = Student.validate_field(telegram, telegram_reg, "Неверный Telegram handle для студента: #{@id} #{@surname} #{@lastname} #{@firstname}")
  end

  # Метод для вывода информации об объекте
  def to_s
    info = "#{@id} #{@surname} #{@firstname} #{@lastname}.\nДанные для связи:\n"
    contact_info = ""
    contact_info += "Номер телефона: #{@phone_number}\n" if @phone_number
    contact_info += "Телеграм: #{@telegram}\n" if @telegram
    contact_info += "Email: #{@email}\n" if @email
    contact_info += "Git: #{@git}\n" if @git
    "#{info}#{contact_info}\n"
  end
end
