require 'spec_helper'

describe Bio::Image::Heatmap do
  before(:each) do
    @data = [[1, 2], [3, 4], [5, 6]]
  end
  
  it "should be created properly" do
    Bio::Image::Heatmap.new @data
  end
end