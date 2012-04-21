
Shorty
================

A Ruby gem that provides DSL to add before/after hooks to method calls.

Installation
------------

    gem install Shorty

Usage: Ruby
------

    require "Shorty"
    
    include Shorty::DSL

    add :ssh, My_SSH_Commands.new
    
    before :ssh, :restart do
      puts "restarting SSH"
    end

    after :ssh, :restart do
      puts "SSH has been restarted"
    end

    run :ssh, :restart

Usage: bin
------

For file `~/uptime.rb`:

    add :uptime, lambda { puts 'uptime' }

    before :uptime, :run do
      puts "starting uptime"
    end

    after :uptime, :run do
      puts "finished uptime"
    end

    run :uptime

In your shell:

    Shorty ~/uptime.rb

Run Tests
---------

    git clone git@github.com:da99/Shorty.git
    cd Shorty
    bundle update
    bundle exec bacon spec/main.rb


