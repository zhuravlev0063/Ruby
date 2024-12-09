require_relative './person.rb'

class Student<Person
  

  def initialize(surname:, firstname:, lastname:, id: nil, phone_number: nil, telegram: nil, email: nil, git: nil)
    super(id: id, git: git, phone_number: phone_number, telegram: telegram, email: email)
    self.surname = surname
    self.firstname = firstname 
    self.lastname = lastname
  end 

  def has_contact_and_git?
    has_contact? && has_git?
  end

  def to_s
    "\nID: #{@id}\nФИО: #{@surname} #{@firstname} #{@lastname} #{"\nНомер телфона: #{@phone_number}" if @phone_number} #{"\nПочта: #{@email}" if @email} #{"\nТелеграм: #{@telegram}" if @telegram} #{"\nGit: #{@git}" if @git}"
  end  


  def self.valid_name?(name)
    name.match?(/^[A-Za-zА-Яа-яЁё]+$/)
  end 
 

  private

  def has_contact?
    @email != nil || @telegram != nil || @phone_number != nil
  end
  
  def has_git?
    @git != nil
  end
  

    def surname=(surname)
      if self.class.valid_name?(surname)
        @surname = surname
      else 
        raise ArgumentError, 'Invalid surname'
      end  
    end
      
    def firstname=(firstname)
      if self.class.valid_name?(firstname) 
        @firstname=firstname
      else 
        raise ArgumentError, 'Invalid firstname'
      end  
    end 

    def lastname=(lastname)
      if self.class.valid_name?(lastname)
        @lastname=lastname
      else 
        raise ArgumentError, 'Invalid lastname'
      end  
    end  
end