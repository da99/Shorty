
describe "Shorty DSL" do
  
  before { extend Shorty::DSL }
  
  it "adds Shorty functionality" do
    a = nil
    add :ssh, lambda { a = :a}  
    run :ssh, :call
    a.should == :a
  end
  
end # === Shorty DSL

