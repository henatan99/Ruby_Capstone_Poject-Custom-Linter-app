require_relative 'file_reader'

class CheckFile
    attr_reader :line_object, :parsed_line

    def initialize(file_object, parsed_line)
        @file_object = file_object
        @parsed_line = parsed_line
    end 

    def line_space(line_object)        
        line_chk = []  
        line_size = line_object.size  
        i = 0    
        while i < line_size 
            start = i 
            break if line_object[i] != ' '
            i += 1
        end 
        for i in (start..line_size) do 
            if i == 1 && line_object[i-1] == ' '
               line_chk << [i]
            end  
            if  line_object[i-1] == ' ' && line_object[i] == ' '
                line_chk << [i]                                             
            end                
        end 
        return line_chk, start 
    end

    def check_space
        @space_array = []
        file_size = @file_object.size
        i = 0 
        file_size.times do
            @space_array << [i, line_space(@file_object[i])[0]]
            i += 1
        end 
        @space_array
    end 

    def line_level        
        @level = []
        @level << 0
        for i in (2..@file_object.size)           
            if ["class", "def", "if", "for", "while", "unless", "loop"].include?(@file_object[i-2][0]) || @file_object[i-2].include?("do")
                @level << 1 + @level[i-2]
            elsif @file_object[i-1].include?("end")
                @level << -1 + @level[i-2]
            else 
                @level << 0 + @level[i-2]
            end               
        end         
        @level
    end     
    
    def indents 
        @indent_array = []
        file_size = @file_object.size
        i = 0
        file_size.times do 
            @indent_array << line_space(@file_object[i])[1]
            i += 1
        end 
        @indent_array 
    end    
    
    def check_indent
        self.indents 
        self.line_level
        indent_chk = []
        file_size = @indent_array.size
        i = 0
        file_size.times do 
            diff = @indent_array[i] - @level[i]
            indent_chk << [i, diff] unless diff == 0
            i += 1
        end 
        indent_chk
    end     
end 

file = ReadFile.new('example.rb')
file_object = file.read_lines
parsed_line = file.parse_lines  

chk_file = CheckFile.new(file_object, parsed_line)

level_array = chk_file.line_level 
init_space = chk_file.indents
chk_indent = chk_file.check_indent
chk_spaces = chk_file.check_space 
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


