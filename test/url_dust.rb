require 'rubygems'
require 'spec'

require "#{File.dirname(__FILE__)}/../lib/pixiedust"

describe UrlDust do
  it "Should recognize 'f 0 0.c0m' as urllike" do
    UrlDust.url_like?('f 0 0.c0m').should == true
  end

end
