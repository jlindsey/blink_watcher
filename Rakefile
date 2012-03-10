desc "Clean out build/ directory"
task :clean do
  puts "Cleaning build/"
  `set -x; rm -rf build/*`
end

desc "Compile CoffeeScript and HAML into build/"
task :build do
  puts "Compiling CoffeeScript"
  Dir['src/coffee/*.coffee'].each do |coffee_file|
    `set -x; coffee --output build/ --compile #{coffee_file}`
  end

  puts

  puts "Compiling HAML"
  Dir['src/haml/*.haml'].each do |haml_file|
    src = File.basename(haml_file).sub('.haml', '.html')
    `set -x; haml -f html5 src/haml/#{File.basename(haml_file)} build/#{src}`
  end
end

task :default => :build

desc 'Clean out build/ and then rebuild project'
task :rebuild => [:clean, :build]

desc "Watch src directory for changes and auto recompile (CoffeeScript only)"
task :watch do
  exec "set -x; coffee -w -o build/ src/coffee/*.coffee"
end

