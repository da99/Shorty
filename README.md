
Shorty
================

A Ruby gem that provides DSL to add before/after hooks to method calls.

Installation
------------

    gem install Shorty

Usage
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


Run Tests
---------

    git clone git@github.com:da99/Shorty.git
    cd Shorty
    bundle update
    bundle exec bacon spec/main.rb

"I hate writing."
-----------------------------

If you know of existing software that makes the above redundant,
please tell me. The last thing I want to do is maintain code.

