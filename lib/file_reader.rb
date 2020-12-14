# File reader class
class ReadFile
  attr_reader :file_name
  def initialize(file_name = 'empty')
    @file_name = file_name
  end

  def open_file
    @file = File.open(@file_name)
  end

  def close_file
    @file = File.close(@file_name)
  end

  def read_lines
    open_file
    @data_lines = @file.readlines
  end

  def parse_lines
    lines = []
    read_lines
    @data_lines.each do |line|
      lines << line.split(' ', 100)
    end
    lines
  end
end
