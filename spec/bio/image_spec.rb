require 'spec_helper'

describe Bio::Image do
  before(:each) do
    @dataset = Statsample::Dataset.new(:x => [1, 2, 3, 4].to_scale, :y => [3, 2, -4, 3].to_scale)
  end
  
  Bio::Image::ATTRIBUTES.each do |attr|
    it "should be possible to set #{attr} attribute on creation" do
      @image = Bio::Image.new @dataset, attr => 'value'
      @image.send(attr).should == 'value'
    end
  end
  
  it "should set current time on creation" do
    Timecop.freeze
    
    @image = Bio::Image.new @dataset
    @image.date.should == Time.now
  end
end