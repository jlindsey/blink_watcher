task :build do
  puts "Compiling CoffeeScript"
  puts `coffee --output build/ --compile src/coffee/*.coffee`
  puts "Compiling HAML"
  puts `haml -f html5 src/haml/*.haml build/`
end

task :default => :build

