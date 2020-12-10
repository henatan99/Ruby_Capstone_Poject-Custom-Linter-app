# rubocop:disable Metrics/LineLength
require_relative '../lib/file_reader'
require_relative '../lib/file_checker'

file = ReadFile.new('example.txt')
file_object = file.read_lines
parsed_line = file.parse_lines

chk_file = CheckFile.new(file_object, parsed_line)
file_size = file_object.size

# Indentation Error Message
indent = chk_file.check_indent
indent.size.times do |i|
  puts "line #{indent[i][0]}: #{indent[i][1].abs} #{indent[i][1].positive? ? 'trailing' : 'leading'} white spaces detected"
end

# Empty line before method
y = []
def_start = chk_file.line_level[1]
def_start.size.times do |i|
  puts "line #{def_start[i][0]}: empty line required above a new method" \
  if def_start[i][0] > 2 && def_start[i][1].zero?
  y << def_start[i][0]
end

# Unecessary empty line
file_size.times do |i|
  puts "line #{i + 1}: Unecessary empty line detected" if parsed_line[i] == [''] \
  && y.any?(i + 2) == false
end

# Unecessary white space detected
line_spaces = chk_file.lines[0]
line_spaces.size.times do |i|
  puts "line #{line_spaces[i][0] + 1}: column #{line_spaces[i][1] + 1}: \
  Unecessary white space detected"
end

# Unclosed tag detection
last_level = chk_file.line_level[0].last
puts "line #{file_size}: Unclosed tag detected " if last_level != 0

# line size detection
max_size = 20
lines_size = chk_file.lines[2]
lines_size.size.times do |i|
  puts "line #{i}: Too long line" if lines_size[i] > max_size
end
# rubocop:enable Metrics/LineLength
