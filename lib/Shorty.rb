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

    def before *args, &blok
      add_hook :before, *args, &blok
    end

    def after *args, &blok
      add_hook :after, *args, &blok
    end

    def add_hook type, name, action, l = nil, &blok
      raise ArgumentError, "lambda and block both given" if l && blok
      list = (type == :before ? befores : afters )
      list[[name, action]] ||= []
      list[[name, action]] << (l || blok)
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

  end # === DSL

  include DSL
  
end # === class Shorty

