# class_student.rb
require './person' # Подключение класса Person

class Student < Person
  def initialize(surname:, firstname:, lastname:, id: nil, phone_number: nil, telegram: nil, email: nil, git: nil)
    super(surname: surname, firstname: firstname, lastname: lastname, id: id, phone_number: phone_number, telegram: telegram, email: email, git: git)
  end

  # Дополнительные методы, специфичные для Student
  def getInfo
    "#{get_full_name} Git: #{@git}, Контакт: #{get_contact}"
  end

  def get_contact
    if !@phone_number.nil?
      "Телефон: #{@phone_number}"
    elsif !@email.nil?
      "Электронная почта: #{@email}"
    elsif !@telegram.nil?
      "Telegram: #{@telegram}"
    else
      "Нет доступных контактов"
    end
  end
end
