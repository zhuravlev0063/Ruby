class Student
  # Автоматическое создание геттеров (только для чтения)
  attr_reader :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  # Автоматическое создание сеттеров (только для записи)
  attr_writer :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  # Конструктор
  def initialize(last_name:, first_name:, middle_name:, id: nil, phone: nil, telegram: nil, email: nil, git: nil)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    @phone = phone
    @telegram = telegram
    @email = email
    @git = git
  end

  # Метод для вывода информации об объекте
  def to_s
    info = "ФИО: #{@last_name} #{@first_name} #{@middle_name}"
    info = "ID: #{@id}, " + info if @id
    info += ", Телефон: #{@phone}" if @phone
    info += ", Телеграм: #{@telegram}" if @telegram
    info += ", Почта: #{@email}" if @email
    info += ", Git: #{@git}" if @git
    info
  end
end
