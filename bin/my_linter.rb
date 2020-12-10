require_relative '../lib/file_reader'
require_relative '../lib/file_checker'

file = ReadFile.new('example.rb')
file_object = file.read_lines
parsed_line = file.parse_lines  

chk_file = CheckFile.new(file_object, parsed_line) 
file_size = file_object.size
file_size.times do |i|    
end 

#Indentation Error Message 
indent = chk_file.check_indent 
indent.size.times do |i|
    puts "line #{indent[i][0]}: #{indent[i][1].abs} #{indent[i][1].positive? ? "trailing" : "leading"} white spaces detected"    
end 


