require 'rubygems'
require 'spec'
require 'statarray'
begin
  require 'ruby-prof'
  profile = true
rescue LoadError
end

require "#{File.dirname(__FILE__)}/../lib/pixiedust"

describe RandomDust do
  #it "Shouldn't generate numbers outside of range" do
  #  min = -5
  #  max = 15
  #  if profile then RubyProf.start; end
  #  1000.times {
  #    val = RandomDust.between(min,max)
  #    val.should <= max
  #    val.should >= min
  #  }
  #  if profile
  #    profile_data = RubyProf.stop
  #    printer = RubyProf::FlatPrinter.new(profile_data)
  #    printer.print(open("profile-#{DateDust.now_str}.txt", "w+"), 0)
  #  end
  #end

  it "Should know how many bytes are really needed by a number" do
    RandomDust.ubytes_needed(1).should == 1
    RandomDust.ubytes_needed(255).should == 1
    RandomDust.ubytes_needed(256).should == 2
    RandomDust.ubytes_needed(65535).should == 2
    RandomDust.ubytes_needed(65536).should == 3
    RandomDust.ubytes_needed(16777215).should == 3
    RandomDust.ubytes_needed(16777216).should == 4
    RandomDust.ubytes_needed(18446744073709551616).should == 9

  end

  it "Should generate numbers at ends of range" do
    min = 0
    max = [1, 4, 555]

    max.each { |x|
      vlist = []
      2000.times {
        vlist << RandomDust.between(min, x)
      }
      vstat = vlist.to_statarray
      #puts "min: #{min}, min seen: #{vstat.min}"
      #puts "max: #{x}, max seen: #{vstat.max}"
      vstat.min.should == min
      vstat.max.should == x
    }
  end

  it "Should generate numbers at ends of range" do
    min = -5
    max = 5
    vlist = []
    100.times {
      vlist << RandomDust.between(min, max)
    }
    vstat = vlist.to_statarray
    #puts "min:    #{vstat.min}"
    #puts "max:    #{vstat.max}"
    vstat.min.should == min
    vstat.max.should == max
  end

  it "Should have roughly equal counts of numbers in range" do
    min = 4
    max = 55
    values = {}
    vlist = []
    100000.times {
      val = RandomDust.between(min, max)
      values[val] ||= 0
      values[val] += 1
      vlist << val
    }

    counts = []
    values.keys.sort.each { |k|
      counts << values[k]
      #puts "#{k}: #{values[k]}"
    }

    cstat = counts.to_statarray
    #puts "median: #{cstat.median}"
    #puts "stddev: #{cstat.stddev}"
    cstat.stddev.should < 50
  end
end
