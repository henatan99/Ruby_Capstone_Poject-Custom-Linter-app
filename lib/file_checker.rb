require_relative 'file_reader'
# CheckFile class
class CheckFile
  TAGS = ['class', 'def', 'if', 'for', 'while', 'unless', 'loop', '}'].freeze
  attr_reader :file_object, :parsed_line

  def initialize(file_object, parsed_line)
    @file_object = file_object
    @parsed_line = parsed_line
  end

  # line_sizes method returns an array of pairs of line index and line size
  def line_sizes(max_line_size)
    @line_size_array = []
    @file_object.each_with_index do |line, index|
      @line_size_array << [index + 1, line.size] if line.size > max_line_size
    end
    @line_size_array
  end

  # white_space returns the column number with unecessary white
  def line_start(line)
    start = 0
    while start < line.size
      break if line[start] != ' '

      start += 1
    end
    start
  end

  # space of a line argument
  def white_space(line)
    return line.size if line[line.size - 2] == ' '

    (line_start(line)..line.size).each do |col|
      return col if line[col - 1] == ' ' && [' ', nil].include?(line[col])
    end
    nil
  end

  def line_space
    @line_space_array = []
    @file_object.each_with_index do |line, idx|
      @line_space_array << [idx + 1, white_space(line)] \
      unless white_space(line).nil?
    end
    @line_space_array
  end

  def method_indent
    @def_start = []
    def_start << 1 if @parsed_line[0].include?('def')
    (2..@parsed_line.size).each do |i|
      x = @parsed_line[i - 2] == [''] ? 1 : 0
      @def_start << [i, x] if @parsed_line[i - 1].include?('def')
    end
    @def_start
  end

  def line_level(line, line_before)
    if TAGS.include?(line_before[0])
      1
    elsif line_before.include?('do')
      1
    elsif line.include?('end')
      -1
    else
      0
    end
  end

  def line_indent
    @level = []
    @level << 0
    (2..@parsed_line.size).each do |i|
      @level << @level[i - 2] + line_level(@parsed_line[i - 1], \
                                           @parsed_line[i - 2])
    end
    @level
  end

  def check_indent
    line_indent
    indent_chk = []
    @file_object.each_with_index do |line, idx|
      diff = line_start(line) - (@level[idx] * 2)
      indent_chk << [idx + 1, diff] if diff.zero? == false && @parsed_line[idx][0].empty? == false
    end
    indent_chk
  end

  def method_check(max_length)
    def_length = []
    method_indent.each do |def_index|
      def_end = 0
      (def_index[0]..line_indent.size).each do |idx|
        def_end += 1
        break if line_indent[idx] == line_indent[def_index[0] - 1]
      end
      def_length << [def_index[0], def_end] if def_end > max_length
    end
    def_length
  end

  def empty_line
    method_indent
    empty_lines = []
    def_start0 = []
    @def_start.each { |item| def_start0 << item[0] }
    @parsed_line.each_with_index do |line_item, idx|
      empty_lines << idx + 1 if line_item[0].empty? \
      && def_start0.include?(idx + 2) == false
    end
    empty_lines
  end
end

# test_file = ReadFile.new('example.txt')
# file_object = test_file.read_lines
# parsed_line = test_file.parse_lines
# test = CheckFile.new(file_object, parsed_line)
# file_test = File.new('example.txt')

# puts test.white_space(file_object[4])
# puts file_object[5].size
