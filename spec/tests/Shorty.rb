
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

describe "Shorty run" do
  
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

end # === Shorty after
