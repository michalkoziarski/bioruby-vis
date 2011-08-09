require 'spec_helper'

describe Bio::Image::Line do
  before(:each) do
    @data = [1, 2, 3]
  end
  
  it "should be created properly" do
    Bio::Image::Line.new @data
    
    @data.to_line
  end
end