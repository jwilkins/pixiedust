require 'rubygems'
require 'spec'

require "#{File.dirname(__FILE__)}/../lib/pixiedust"

describe HashDust do
  it "Should get the same value as command line md5sum" do
    md5sum = `md5sum #{__FILE__} | cut -f 1 -d ' '`.strip
    HashDust.md5_file(__FILE__).should == md5sum
  end

end
