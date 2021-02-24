require_relative '../lib/file_reader'
require_relative '../lib/file_checker'

puts 'Insert the name and path of the file for rubocop linter: '
file_name = gets.chomp
puts File.exist?(file_name) ? 'file exists' : 'file does not exist'
exit_string = %w[e exit]
while File.exist?(file_name) == false
  exit if exit_string.include?(file_name)
  puts "File is not found, try again or exit with 'e' or 'exit' "
  file_name = gets.chomp
end

read_object = ReadFile.new(file_name)
file_object = read_object.read_lines
parsed_line = read_object.parse_lines

chk_file = CheckFile.new(file_object, parsed_line)
file_size = file_object.size

# Indentation Error Message
indent = chk_file.check_indent
indent.each do |indent_item|
  puts "line #{indent_item[0]}: #{indent_item[1].abs} \
  #{indent_item[1].positive? ? 'more' : 'less'} indent space detected"
end

# Empty line before method
def_start = chk_file.method_indent
def_start.each do |def_item|
  puts "line #{def_item[0]}: empty line required above a new method" \
  if def_item[1].zero? && def_item[0] > 2
end

# Unecessary empty line
empty_lines = chk_file.empty_line
empty_lines.each do |empty_line_item|
  puts "line #{empty_line_item}: Unecessary empty line detected"
end

# Unecessary white space detected
line_spaces = chk_file.line_space
line_spaces.each do |line_space_item|
  puts "line #{line_space_item[0]}: column #{line_space_item[1]}: \
  Unecessary white space detected"
end

# Unclosed tag detection
last_level = chk_file.line_indent.last
puts "line #{file_size}: Unclosed tag detected " if last_level != 0

# line size detection
max_size = 20
lines_size = chk_file.line_sizes(max_size)
lines_size.each do |line_size_item|
  puts "line #{line_size_item[0]}: Too long line \
  #{line_size_item[1]}/#{max_size}"
end

# method length detection
max_length = 15
method_length = chk_file.method_check(max_length)
method_length.each do |method_length_item|
  puts "line #{method_length_item[0]}: Too long method \
  #{method_length_item[1]}/#{max_length}"
end

# Close file
read_object.close_file
