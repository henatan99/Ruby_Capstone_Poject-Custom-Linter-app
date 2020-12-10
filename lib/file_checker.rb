# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/LineLength
# rubocop:disable Style/For
require_relative 'file_reader'
#CheckFile class 
class CheckFile
  attr_reader :file_object, :parsed_line

  def initialize(file_object, parsed_line)
    @file_object = file_object
    @parsed_line = parsed_line
  end

  def lines
    @line_space_array = []
    @line_start_array = []
    @line_size_array = []
    j = 0

    @file_object.size.times do
      line_object = @file_object[j]
      line_spaces = []
      line_size = line_object.size
      i = 0
      while i < line_size
        start = i
        break if line_object[i] != ' '
    
        i += 1
      end

      for i in (start..line_size) do
        line_spaces << i if line_object[i - 1] == ' ' && line_object[i] == ' '
      end
      @line_space_array << [j, line_spaces[0]] unless line_spaces.empty?
      @line_start_array << start
      @line_size_array << line_size
      j += 1
    end
    [@line_space_array, @line_start_array, @line_size_array]
  end

  def line_level
    @level = []
    @level << 0
    @def_start = []
    @def_start << 1 if @parsed_line[0].include?('def')
    for i in (2..@parsed_line.size)
      if ['class', 'def', 'if', 'for', 'while', 'unless', 'loop', '}'].include?(@parsed_line[i - 2][0]) || @parsed_line[i - 2].include?('do')
        @level << 1 + @level[i - 2]
      elsif @parsed_line[i - 1].include?('end')
        @level << -1 + @level[i - 2]
      else
        @level << 0 + @level[i - 2]
      end
      x = @parsed_line[i - 2] == [''] ? 1 : 0
      @def_start << [i, x] if @parsed_line[i - 1].include?('def')
    end
    [@level, @def_start]
  end

  def check_indent
    line_level
    lines
    indent_chk = []
    file_size = @line_start_array.size
    i = 0
    file_size.times do
      diff = @line_start_array[i - 1] - (@level[i - 1] * 2)
      indent_chk << [i, diff] unless diff.zero? || @parsed_line[i - 1][0].empty?
      i += 1
    end
    indent_chk
  end

  def method_check
    line_level
    j = 0
    def_length = []
    @def_start.size.times do
      start = @def_start[j][0]
      count = 0
      for i in (start..@level.size)
        count += 1
        break if @level[i] == @level[start - 1]
      end
      def_length << [@def_start[j][0], count + 1]
      j += 1
    end
    def_length
  end
end

# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/LineLength
# rubocop:enable Style/For
