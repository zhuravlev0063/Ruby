# class_person.rb
class Person
  attr_accessor :id, :surname, :firstname, :lastname
  attr_reader :git, :telegram, :email, :phone_number

  def initialize(surname:, firstname:, lastname:, id: nil, phone_number: nil, telegram: nil, email: nil, git: nil)
    @id = id
    self.surname = surname
    self.firstname = firstname
    self.lastname = lastname
    self.phone_number = phone_number
    @telegram = telegram
    self.email = email
    @git = git
  end

  def surname=(surname)
    if self.class.is_name_valid?(surname)
      @surname = surname
    else
      raise ArgumentError.new("Неверная фамилия:\n#{@id}")
    end
  end

  def firstname=(firstname)
    if self.class.is_name_valid?(firstname)
      @firstname = firstname
    else
      raise ArgumentError.new("Неверное имя:\n#{@id} #{@surname}")
    end
  end

  def lastname=(lastname)
    if lastname.empty? || self.class.is_name_valid?(lastname)
      @lastname = lastname
    else
      raise ArgumentError.new("Неверное отчество:\n#{@id} #{@surname} #{@firstname}")
    end
  end

  def phone_number=(phone_number)
    if phone_number.nil? || self.class.is_phone_number_valid?(phone_number)
      @phone_number = phone_number
    else
      raise ArgumentError.new("Неверный номер телефона:\n#{@id} #{@surname} #{@lastname} #{@firstname}")
    end
  end

  def email=(email)
    if email.nil? || self.class.is_email_valid?(email)
      @email = email 
    else
      raise ArgumentError.new("Неверный адрес электронной почты:\n#{@id} #{@surname} #{@lastname} #{@firstname}")
    end
  end

  def git=(git)
    if git.nil? || self.class.is_git_valid?(git)
      @git = git
    else
      raise ArgumentError.new("Неверный git:\n#{@id} #{@surname} #{@lastname} #{@firstname}")
    end
  end

  def self.is_phone_number_valid?(checked_phone_number)
    phone_number_reg = /^\+?\d{1,3}\s?\(?\s*\d{3}\s*\)?\s?\d{3}\-{0,1}\d{2}\-{0,1}\d{2}\s*$/
    !!(checked_phone_number =~ phone_number_reg)
  end

  def self.is_email_valid?(checked_email)
    email_reg = /^[A-Za-z0-9._-]+\@[A-Za-z0-9._-]+\.[A-Za-z0-9._-]+/
    !!(checked_email =~ email_reg)
  end

  def self.is_name_valid?(checked_name)
    name_reg = /^[A-Za-zА-яа-я]+$/
    !!(checked_name =~ name_reg)
  end

  def self.is_git_valid?(checked_git)
    git_reg = /^(https|http):\/\/github.com\/[A-Za-z0-9._-]+\/?$/
    !!(checked_git =~ git_reg)
  end

  def get_full_name
    "#{@surname} #{@firstname} #{@lastname}"
  end

  def to_s
    "#{@id} ФИО: #{@surname} #{@firstname} #{@lastname}.\n" \
    "Телефон: #{@phone_number}\n" \
    "Телеграм: #{@telegram}\n" \
    "Email: #{@email}\n" \
    "Git: #{@git}\n\n"
  end
end
