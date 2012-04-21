

describe "permissions of bin/" do
  
  bins = Dir.glob("bin/*")
  
  bins.each { |file|
    it "should chmod 755 for: #{file}" do
      `stat -c %a #{file}`.strip
      .should.be == "755"
    end
  }
  
end # === permissions of bin/

describe "Shorty bin" do
  
  it "runs file that includes Shorty DSL" do
    Exit_0("Shorty spec/files/uptime.rb").out.split
    .should == %@ 
      starting uptime
      uptime
      finished uptime
    @.split
  end

  it "runs file only once despite same file, different relative paths" do
    Exit_0("Shorty spec/files/uptime.rb ./spec/files/uptime.rb").out.split
    .should == %@ 
      starting uptime
      uptime
      finished uptime
    @.split
  end

end # === Shorty bin
