
add :uptime, lambda { puts 'uptime' }

before :uptime, :call do
  puts "starting uptime"
end

after :uptime, :call do
  puts "finished uptime"
end

run :uptime, :call
