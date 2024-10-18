class Student
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

  # Геттеры
  def id
    @id
  end

  def last_name
    @last_name
  end

  def first_name
    @first_name
  end

  def middle_name
    @middle_name
  end

  def phone
    @phone
  end

  def telegram
    @telegram
  end

  def email
    @email
  end

  def git
    @git
  end

  # Сеттеры
  def id=(new_id)
    @id = new_id
  end

  def last_name=(new_last_name)
    @last_name = new_last_name
  end

  def first_name=(new_first_name)
    @first_name = new_first_name
  end

  def middle_name=(new_middle_name)
    @middle_name = new_middle_name
  end

  def phone=(new_phone)
    @phone = new_phone
  end

  def telegram=(new_telegram)
    @telegram = new_telegram
  end

  def email=(new_email)
    @email = new_email
  end

  def git=(new_git)
    @git = new_git
  end
end
