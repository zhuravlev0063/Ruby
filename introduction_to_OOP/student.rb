class Student
  attr_accessor :surname, :firstname, :lastname, :id, :phone_number, :telegram, :email, :git

  # Конструктор с проверкой номера телефона
  def initialize(surname, firstname, lastname, id: nil, phone_number: nil, telegram: nil, email: nil, git: nil)
    @surname = surname
    @firstname = firstname
    @lastname = lastname
    @id = id

    # Проверка номера телефона через метод класса
    if Student.is_phone_number_valid?(phone_number)
      @phone_number = phone_number
    else
      raise ArgumentError.new("Неверный номер телефона для пользователя #{@id} #{@surname} #{@firstname} #{@lastname}")
    end

    @telegram = telegram
    @email = email
    @git = git
  end

  # Метод класса для проверки номера телефона
  def self.is_phone_number_valid?(checked_phone_number)
    phone_number_reg = /^\+?\d\s?\(?\s*\d{3}\s*\)?\s?\d{3}\-{0,1}\d{2}\-{0,1}\d{2}\s*$/
    return checked_phone_number =~ phone_number_reg
  end

  # Метод для вывода информации об объекте
  def to_s
    info = "#{@id} ФИО: #{@surname} #{@firstname} #{@lastname}.\n"
    contact_info = "Данные для связи:\n"
    contact_info += "Номер телефона: #{@phone_number}\n" if @phone_number
    contact_info += "Телеграм: #{@telegram}\n" if @telegram
    contact_info += "Email: #{@email}\n" if @email
    contact_info += "Git: #{@git}\n" if @git
    "#{info}#{contact_info}\n"
  end
end
