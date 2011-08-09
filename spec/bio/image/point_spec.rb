require 'spec_helper'

describe Bio::Image::Point do
  before(:each) do
    @data = [1, 2, 3]
  end
  
  it "should be created properly" do
    Bio::Image::Point.new @data
    
    @data.to_point
  end
end