
file = File.open("file.txt", "r")
file.each_line{|line| puts line}
file.close()