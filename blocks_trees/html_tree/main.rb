require_relative 'html_tree.rb'
require_relative 'tag'
tree = HTML_tree.new('<div class="class"><p><span>hello</span></p><p><span>world</span></p></div>')
puts 'dfs'
tree.dfs.each do |element|
  puts "#{element}"
end

puts "\nbfs"
tree.bfs.each do |element|
  puts "#{element}"
end


puts "select" 
array = tree.bfs.select { |element| element.has_content?}
puts array