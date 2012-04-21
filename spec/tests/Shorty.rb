
module My_Box
  
  class << self
    def run 
      "My_Box run"
    end
     
    def custom
      "My_Box custom"
    end

  end # === class
end # === My_Box

describe "Shorty :add" do
  
  it "raises ArgumentError if both lambda and block are given" do
    lambda {
      s = Shorty.new
      l = lambda {}
      s.add :my_box, l do
      end
    }.should.raise(ArgumentError)
    .message.should.match %r!lambda and block both given!
  end

  it "accepts a block as a value" do
    p = Proc.new {}
    s = Shorty.new
    s.add :my_box, &p
    s.shortys[:my_box].should == p
  end

  it "accepts a lambda as a value" do
    l = lambda {}
    s = Shorty.new
    s.add :my_box, l
    s.shortys[:my_box].should == l
  end

end # === Shorty :add

describe "Shorty :run" do
  
  before { 
    @s = Shorty.new
    @s.add :my_box, My_Box
  }
  
  it "sets default action to :run" do
    @s.run(:my_box)
    .should == "My_Box run"
  end

  it "runs target action" do
    @s.run(:my_box, :custom)
    .should == "My_Box custom"
  end
  
end # === Shorty run


describe "Shorty before" do
  
  it "runs before hooks before run" do
    s = Shorty.new
    t = []
    s.add :test, lambda { t << :t }
    s.before :test, :run do
      t << :b
    end

    s.run :test
    t.should == [:b, :t]
  end
  
  it "accepts a block" do
    s = Shorty.new
    t = []
    s.add :test, lambda { t << :t }
    s.before :test, :run do
      t << :b
    end

    s.run :test
    t.should == [:b, :t]
  end

  it "accepts a lambda instead of a block" do
    s = Shorty.new
    t = []
    s.add :test, lambda { t << :t }
    s.before :test, :run, lambda {
      t << :b
    }

    s.run :test
    t.should == [:b, :t]
  end
  
  it "raises ArgumentError if both a lambda and a block are given" do
    s = Shorty.new
    s.add :test, lambda {}
    lambda {
      l = lambda {}
      s.before(:test, :run, l) {}
    }.should.raise(ArgumentError)
    .message.should.match %r!lambda and block both given!
  end

end # === Shorty before


describe "Shorty after" do
  
  it "runs after hooks after run" do
    s = Shorty.new
    t = []
    s.add :test, lambda { t << :t }
    s.after :test, :run do
      t << :a
    end

    s.run :test
    t.should == [:t, :a]
  end
  
  it "accepts a block" do
    s = Shorty.new
    t = []
    s.add :test, lambda { t << :t }
    s.after :test, :run do
      t << :a
    end

    s.run :test
    t.should == [:t, :a]
  end

  it "accepts a lambda instead of a block" do
    s = Shorty.new
    t = []
    s.add :test, lambda { t << :t }
    s.after :test, :run, lambda {
      t << :a
    }

    s.run :test
    t.should == [:t, :a]
  end
  
  it "raises ArgumentError if both a lambda and a block are given" do
    s = Shorty.new
    s.add :test, lambda {}
    lambda {
      l = lambda {}
      s.after(:test, :run, l) {}
    }.should.raise(ArgumentError)
    .message.should.match %r!lambda and block both given!
  end

end # === Shorty after
