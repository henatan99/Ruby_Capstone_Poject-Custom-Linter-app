class ReadFile 
    def initialize(file_name = 'empty')
        @file_name = file_name 
    end 

    def open_file
        @file = File.open(@file_name)
    end 

    def read_file       
       @data  = @file.read                 
    end

    def read_lines       
        @data_lines = @file.readlines                   
    end 

    def parse_lines
        lines = []
        @data_lines.each do |line|            
            lines << line.split(' ', 100)             
        end 
        return lines
    end        
end 

file = ReadFile.new("example.rb")
file.open_file 
line_read = file.read_lines
my_lines = file.parse_lines
i = 1
my_lines.each do |line|
   puts "line #{i}: #{line}"
   i += 1 
end 
