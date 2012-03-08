desc "Clean out build/ directory"
task :clean do
  `rm -rf build/*`
end

desc "Compile CoffeeScript and HAML into build/"
task :build do
  puts "Compiling CoffeeScript"
  Dir['src/coffee/*.coffee'].each do |coffee_file|
    puts "Compiling #{coffee_file}"
    `coffee --output build/ --compile #{coffee_file}`
  end

  puts

  puts "Compiling HAML"
  Dir['src/haml/*.haml'].each do |haml_file|
    puts "Compiling #{haml_file}"
    `haml -f html5 src/haml/*.haml build/#{File.basename(haml_file).sub('.haml', '.html')}`
  end
end

task :default => :build

desc "Watch src directory for changes and auto recompile (CoffeeScript only)"
task :watch do
  exec "coffee -w -o build/ src/coffee/*.coffee"
end

