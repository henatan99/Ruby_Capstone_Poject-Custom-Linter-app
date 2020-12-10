class ReadFile 
    def initialize(file_name = 'empty')
        @file_name = file_name 
    end 

    def open_file
        @file = File.open(@file_name)
    end 

    def read_lines    
        self.open_file            
        @data_lines = @file.readlines                   
    end 

    def parse_lines
        lines = []
        self.read_lines
        @data_lines.each do |line|            
            lines << line.split(' ', 100)             
        end 
        return lines
    end        
end 

