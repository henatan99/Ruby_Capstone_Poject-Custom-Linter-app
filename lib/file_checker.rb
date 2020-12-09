# require 'file_reader'
class CheckFile

    def line_level(parsed_line)
        level = []
        for i in (1..parsed_line.size)
            if i == 1 
                level << 1
            end 
            if i > 1 
                if ["class", "def", "if", "for", "while", "unless"].include?(parsed_line[i-1][0]) || parsed_line[i-1].include?("do")
                    level << 1
                end  
                if parsed_line[i-1].include?("end")
                    level << -1
                else 
                    level << 0
                end  
            end 
        end 
        level
    end 

    def space_check(line_object)
        line_chk = []
        
        for i in (1..line_object.size) do 
            if i == 1 && line_object[i-1] == ' '
               line_chk << [i]
            end  
            if  line_object[i-1] == ' ' && line_object[i] == ' '
                line_chk << [i]                                             
            end                
        end 
        line_chk
    end 
end 
line_obj = " I am a disco   {dancer}   "
chk_file = CheckFile.new 
checked_line = chk_file.space_check(line_obj)
puts checked_line.size
puts checked_line[0][0]
puts checked_line[1][0]

parsed = [["class", "Block"], ["def", "initialize"], ["@name", "=", "name"], ["end"], ["def", "slack"], ["bit"], ["end"], ["stash"], ["end"]]
puts "let's check line levels"
puts lin_lvl = chk_file.line_level(parsed)
