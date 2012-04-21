
add :uptime, lambda { puts 'uptime' }

before :uptime, :run do
  puts "starting uptime"
end

after :uptime, :run do
  puts "finished uptime"
end

run :uptime
