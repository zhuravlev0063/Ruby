class Tag
  attr_accessor :name, :attrs, :children, :content

  def initialize(name: nil, attrs: {}, children: [], content: '')
    self.name = name
    self.attrs = attrs
    self.children = children
    self.content = content
  end

  def add_child(child)
    children << child
  end

  def to_s
    if single?
      return single
    else 
      return opening
    end
  end
  
  def opening
    "<#{self.name}#{has_atrributes? ? self.attrs.map{|k,v| "#{k}=\"#{v}\""}.join(' ') : ''}>#{has_content? ? self.content : ''}"
  end

  def closing
    "<#{self.name}>"
  end

  def single
    "<#{self.name} #{self.attrs.map{|k,v| "#{k}=\"#{v}\""}.join(' ')}/>"
  end

  def count_of_children
    children.length
  end

  def self.parse_name(string)
    string[1..-2].split.first                   
  end

  def self.parse_attrs(string)
    attrs = {}
    string.scan(/([a-zA-Z]+)="([^" >]*)"/) do |key, value|
      attrs[key] = value
    end
    attrs
  end


  def single?
    ['img', 'form'].include?(self.name)
  end

  def has_atrributes?
    self.attrs.any?
  end

  def has_content?
    self.content.length > 0
  end
  
end