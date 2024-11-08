require_relative './person.rb'

class Student_short < Person

  attr_accessor :fullname, :contact

  private :fullname=, :contact=

  def self.create_from_student(student)
    new(id: student.id, git: student.git, fullname: student.fullname, contact: student.contact)
  end  

  def self.from_string(id:,string:)
    fullname, contact, git= read_info_from_string(string)
    new(id: id, fullname: fullname, contact: contact, git: git)
  end
  
  def self.read_info_from_string(string)
    fullname,contact,git = string.split(', ')
    return fullname,contact,git
  end  
  
  def to_s
    "\nID: #{@id} \nFullname: #{@fullname} \nGit: #{@git} \nContact: #{@contact}"
  end

  private_class_method :new

  def initialize(id: nil, fullname: nil, git: nil, contact: nil)
    super(id: id, git: git)
    self.fullname = fullname
    self.contact = contact
  end 
end  