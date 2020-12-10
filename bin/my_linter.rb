require_relative '../lib/file_reader'
require_relative '../lib/file_checker'

file = ReadFile.new('example.rb')
file_object = file.read_lines
parsed_line = file.parse_lines  

chk_file = CheckFile.new(file_object, parsed_line)

level_array = chk_file.line_level 

chk_indent = chk_file.check_indent
chk_spaces = chk_file.lines[0]
# puts level_array
# puts init_space
# puts chk_indent
puts chk_spaces[0]
puts '------------'
puts chk_spaces[1]
puts '------------'
puts chk_spaces[2]
puts '------------'
puts chk_spaces[3]
puts '------------'
puts chk_spaces[4]
puts '------------'
puts chk_spaces[5]
puts '------------'
puts chk_spaces[6]