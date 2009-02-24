require 'rubygems'
require 'spec'

require "#{File.dirname(__FILE__)}/../lib/pixiedust"

describe ActiveRecord do
  it "Should have an each method" do
    ActiveRecord::Base.methods.index('each') should not = nil
  end
end
