#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), "spec_helper")

require 'utility_belt/language_greps'

describe "language greps" do

  it "should handle String#blank?" do
    "".should be_blank
  end

end
