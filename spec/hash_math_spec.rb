require File.join(File.dirname(__FILE__), "spec_helper")
require "lib/utility_belt/hash_math"
describe "Hash math" do
  
  before do
    @a = { :a => 1 }
    @b = { :b => 2 }
    @c = { :a => 1, :b => 2}
  end
  
  it "should add hashes" do
    ({:a => :b} + {:c => :d}).should == {:a => :b, :c => :d}
  end

  it "should subtract hashes" do
    ({:a => :b, :c => :d} - {:c => :d}).should == {:a => :b}
  end

  it "should subtract key/value pairs by key" do
    ({:a => :b, :c => :d} - :c).should == {:a => :b}
  end
  
  it "should return a new object instead of mutating the operands" do
    (@c - @a).should_not === @c
  end
  
  it "should not alter the state of the operands" do
    (@c - @b).should == @a # but...
    @c.should == { :a => 1, :b => 2 }
  end

end
