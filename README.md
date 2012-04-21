
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

    class My_SSH
      def self.restart
      end
    end
    
    add :ssh, My_SSH
    
    before :ssh, :restart do
      puts "restarting SSH"
    end

    after :ssh, :restart do
      puts "SSH has been restarted"
    end

    run :ssh, :restart 
    
    # --> My_SSH.restart is run with before/after hooks.

You can also use lambdas instead of regular objects/classes:
   
    add    :ssh, lambda { `service ssh restart` }
    before :ssh, :run, lambda { puts 're-starting ssh' }
    after  :ssh, :run, lambda { puts 'finished re-starting ssh' }

    run :ssh  
    
    # equivalent to...
    run :ssh, :run
    
    # --> "lambda { `service ssh restart` }.call" is called.

Shorty is implemented [in just one file](https://github.com/da99/Shorty/blob/master/lib/Shorty.rb)
in case you have any more questions.

Usage: Shorty (executable)
------

Write a Ruby file, `~/uptime.rb`, that uses the Shorty DSL:

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


