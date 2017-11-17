puts "Creating Ruby project with the following structure:"

commands = [
  "mkdir lib",
  "mkdir spec",
  "touch Gemfile",
  "touch lib/main.rb",
  "touch spec/main_spec.rb",
  "touch .gitignore"
]

commands.each {|c| puts "Executing command: #{c}"; system(c)}

gemfile = <<-GEMFILE
source 'https://rubygems.org'

gem 'pry'
gem 'rspec'
GEMFILE

puts "Populating Gemfile"
File.open("Gemfile", "w") do |f|
  f.puts gemfile
end

gitignore = <<-GITIGNORE
tags

*.swp
*.swo
*~
GITIGNORE

puts "Populating .gitignore"
File.open(".gitignore", "w") do |f|
  f.puts gitignore
end

puts "Bundling"
system("bundle install")

puts "Add everything to git"
system('git init && git add . && git commit -m "Start new project"')

puts "Running RSpec"
system("bundle exec rspec")

puts "Finished"
