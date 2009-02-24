require 'rubygems'
require 'spec'

require "#{File.dirname(__FILE__)}/../lib/pixiedust"

describe NumberDust do
  it "Shouldn't round small numbers" do
    val = NumberDust.nearest(0)
    val.should == 0
    val = NumberDust.nearest(9)
    val.should == 9
    val = NumberDust.nearest(1005)
    val.should == 1005
  end

  it "Should round big numbers" do
    val = NumberDust.nearest(10005)
    val.should == 10000
    val = NumberDust.nearest(10805)
    val.should == 10000
    val = NumberDust.nearest(11805)
    val.should == 11000
    val = NumberDust.nearest(1181805)
    val.should == 1100000
  end
end
