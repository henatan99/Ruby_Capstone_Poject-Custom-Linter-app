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

    def parse_byspace
        parse = String.new
        big_parse = Array.new
        for i in (1..@data.length) do                
            parse << @data[i-1]   
                   
            if @data[i] == ' '  && @data[i-1] != ' ' 
                big_parse << parse 
                parse = []            
            end     
        end 
        big_parse << parse
        big_parse
    end   
      
end 

file = ReadFile.new("example.rb")
file.open_file 
file_read = file.read_file
big_parse = file.parse_byspace

puts big_parse.size

puts big_parse[0]
puts '------------'
puts big_parse[1]
puts '------------'
puts big_parse[2]
puts '------------'
puts big_parse[3]
puts '------------'
puts big_parse[4]
