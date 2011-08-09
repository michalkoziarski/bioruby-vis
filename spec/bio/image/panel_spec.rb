require 'spec_helper'

describe Bio::Image::Panel do
  before(:each) do
    @array = [1, 2, 3]
    @matrix = [[1, 2], [3, 4], [5, 6]]
    
    @images = []
    
    @images << @array.to_bar
    @images << @array.to_line
    @images << @array.to_point
    @images << Bio::Image::Scatterplot.new(@array)
    @images << Bio::Image::Timecourse.new(@array)
    @images << Bio::Image::Heatmap.new(@matrix)
  end
  
  it "should be created properly" do
    Bio::Image::Panel.new *@images
  end
end