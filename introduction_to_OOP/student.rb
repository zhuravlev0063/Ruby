class Student
  # Геттеры для всех полей, но без сеттеров для контактов
  attr_accessor :id
  attr_reader :surname, :firstname, :lastname, :phone_number, :telegram, :email, :git

  # Конструктор
  def initialize(surname, firstname, lastname, id: nil, phone_number: nil, telegram: nil, email: nil, git: nil)
    self.surname = surname
    self.firstname = firstname
    self.lastname = lastname
    @id = id
    self.git = git
    set_contacts(phone_number: phone_number, telegram: telegram, email: email)
    validate
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

  # Публичный метод для установки контактов
  def set_contacts(phone_number: nil, telegram: nil, email: nil)
    @phone_number = Student.validate_field(phone_number, /^\+?\d{1,3}\s?\(?\s*\d{3}\s*\)?\s?\d{3}-?\d{2}-?\d{2}\s*$/, "Неверный номер телефона: #{@id} #{@surname} #{@firstname}") if phone_number
    @telegram = telegram
    @email = Student.validate_field(email, /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/, "Неверный адрес электронной почты: #{@id} #{@surname} #{@firstname}") if email
    validate_contact_presence
  end

  # Валидация Git
  def git=(git)
    git_reg = /^https:\/\/github\.com\/[A-Za-z0-9._-]+\/?$/
    @git = Student.validate_field(git, git_reg, "Неверная ссылка Git: #{@id} #{@surname} #{@lastname} #{@firstname}")
    validate_git_presence
  end

  # Метод для общей проверки валидности
  def self.validate_field(value, regex, error_message)
    return value if value.nil? || value =~ regex

    raise ArgumentError.new(error_message)
  end

  # Метод для проверки наличия Git
  def validate_git_presence
    raise ArgumentError.new("У студента #{@id} #{@surname} #{@firstname} отсутствует ссылка на GitHub") if @git.nil?
  end

  # Метод для проверки наличия хотя бы одного контакта
  def validate_contact_presence
    if @phone_number.nil? && @telegram.nil? && @email.nil?
      raise ArgumentError.new("У студента #{@id} #{@surname} #{@firstname} должен быть указан хотя бы один контакт")
    end
  end

  # Метод для запуска всех валидаций
  def validate
    validate_git_presence
    validate_contact_presence
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

  private
  # Контакты теперь можно установить только через set_contacts
  attr_writer :phone_number, :telegram, :email
end
