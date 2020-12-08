def read_file(user_file)
    file = File.open(user_file)
    for line in file.readlines()
        puts line
    end    
    puts file     
end 

read_file("example.rb")

