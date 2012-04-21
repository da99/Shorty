
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

You can also use lambdas or a code block:
   
    add :start, lambda { `service ssh restart` }
    
    add :stop do 
      `service ssh stop`
    end

    before :start, :call, lambda { puts 're-starting ssh' }
    
    after  :stop, :call do
      puts 'ssh stopped'
    end

    run :start, :call
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

Usage: Best Practices
-----

You are not allowed to pass arguments to :run calls:

    # Not possible:
    run :ssh, :restart, "my arg"

This is intentional. You want to put all logic in a separate class/object.
For example, let's say you use a different command for SSH start and restart
depending on the OS. In your Ruby file, you put:

    require "./My_SSH"
    add :ssh, My_SSH
    run :ssh, :start

In a separate file, `My_SSH.rb`:

    require "ohai"

    O = Ohai::System.new
    O.all_plugins
    
    class My_SSH
      class << self
      
        def start
          case O[:platform]
          when "ubuntu"
            "service ssh start"
          when ...
            ....
          end
        end
        
      end
    end

If :run allowed arguments, you would be very tempted to 
write Shorty/Ruby code with lots of mixed in logic:

    if O[:platform] == 'ubuntu'
      run :ssh, :restart, "sudo service ssh restart"
    else
      run :ssh, :restart, "some_program sshd start -now"
    end

In summary: 

* Write short lines of Shorty/Ruby code.
* Hide complicated logic in separate Ruby classes and objects.

Run Tests
---------

    git clone git@github.com:da99/Shorty.git
    cd Shorty
    bundle update
    bundle exec bacon spec/main.rb


