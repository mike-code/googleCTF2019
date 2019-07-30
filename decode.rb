F = File.read("data").split("\n").map { |e| e.gsub ' ', ''  }.join

File.write('wynik.png',  [F].pack('H*'))


