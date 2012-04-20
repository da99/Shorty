require 'Shorty/version'

class Shorty
  
  module DSL

    def shortys 
      @shortys ||= Hash[]
    end

    def befores
      @befores ||= Hash[]
    end

    def afters
      @afters ||= Hash[]
    end

    def add name, val = :_NONE_
      if name.is_a?(String) && val == :_NONE_
        file = File.expand_path(name)
        (file = "#{file}.rb") unless File.exists?(file)
        eval File.read(file), nil, file, 1
        return true
      end
      raise ArgumentError, "#{name.inspect} already set" if shortys[name]
      shortys[name] = val
    end

    def before name, action, &blok
      befores[[name, action]] ||= []
      befores[[name, action]] << blok
    end

    def after name, action, &blok
      afters[[name, action]] ||= []
      afters[[name, action]] << blok
    end

    def run_hooks group, name, action, package
      list = group[[name,action]] 
      (list || []).each { |pr|
        if pr.arity == 0
          pr.call
        else
          pr.call package
        end
      }
    end

    def run name, action = nil

      r = shortys[name]
      raise ArgumentError, "#{name.inspect} not found" unless r
      action ||= :run

      run_hooks befores, name, action, r 
      
      result = if r.is_a?(Proc) && action == :run
        r.call
      else
        r.send action
      end
      
      run_hooks afters,  name, action, r 

      result
    end # === def package

    def executable? name
      `which #{name}`.strip.empty?
    end

  end # === DSL

  include DSL
  
end # === class Shorty

