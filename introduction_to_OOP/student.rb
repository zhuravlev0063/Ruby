# class_student.rb
# Подкласс Student представляет более подробную информацию о студенте, расширяя базовые атрибуты класса Person.

require './person' # Подключение базового класса Person

class Student < Person
  # Конструктор класса Student, который вызывает конструктор суперкласса Person
  def initialize(surname:, firstname:, lastname:, id: nil, phone_number: nil, telegram: nil, email: nil, git: nil)
    # Вызов конструктора родительского класса с передачей всех параметров
    super(surname: surname, firstname: firstname, lastname: lastname, id: id, phone_number: phone_number, telegram: telegram, email: email, git: git)
  end

  # Метод для получения информации о студенте в кратком формате
  # Возвращает Фамилию, Имя и Инициалы, а также Git и контактную информацию
  def getInfo
    "#{get_full_name} Git: #{@git}, Контакт: #{get_contact}"
  end

  # Метод для получения доступной контактной информации о студенте
  # Проверяет наличие каждого типа контакта и возвращает первый найденный, если он есть
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
