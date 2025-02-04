require 'json'
require_relative 'student_short'
require_relative 'student'
require_relative 'file_handler'

class StudentListJSON<FileHandler

  def read_list_of_students
    file = File.read(self.path)
    raise 'File is empty' if file.strip.empty?
    JSON.parse(file, symbolize_names: true).map do |object|
      Student.new(**object)
    end
  end
  def write_list_of_students(list)
    data = list.map do |object|
      object.to_h
    end
    File.open(self.path, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end
end