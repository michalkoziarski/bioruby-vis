require 'spec_helper'

describe Bio::Image do
  before(:each) do
    @dataset = Statsample::Dataset.new(:x => [1, 2, 3, 4].to_scale, :y => [3, 2, -4, 3].to_scale)
  end
  
  it "should be created properly" do
    Bio::Image.new @dataset
  end
  
  Bio::Image::ATTRIBUTES.each do |attr|
    it "should be possible to set #{attr} attribute on creation" do
      @image = Bio::Image.new @dataset, attr => 0
      @image.send(attr).should == 0
    end
  end
  
  it "should keep copy of data" do
    @image = Bio::Image.new @dataset
    @image.send(:original_data).should == @dataset
  end
  
  it "should keep copy of options" do
    @options = {:test => :hash}
    
    @image = Bio::Image.new @dataset, @options
    @image.send(:options).should == @options
  end
  
  describe "default options" do
    it "@net should be set to true by default" do
      @image = Bio::Image.new @dataset
      @image.send(:net).should == true
    end
    
    it "@net should have value passed in options" do
      @image = Bio::Image.new @dataset, :net => false
      @image.send(:net).should == false
    end
    
    %w( width height ).each do |attr|
      it "@#{attr} should be set to Bio::Image::DEFAULT_#{attr.upcase} by default" do
        @image = Bio::Image.new @dataset
        @image.send(attr).should == eval("Bio::Image::DEFAULT_#{attr.upcase}")
      end
    end
  end
  
  describe "normalize data" do
    it "should normalize @data so that every value would respond to .x and .y" do
      @image = Bio::Image.new @dataset
      @data = @image.send(:data)
      
      @data.each do |data|
        data.should respond_to :x
        data.should respond_to :y
      end
    end
    
    it "should create @x and @y scales" do
      @image = Bio::Image.new @dataset
      
      [:x, :y].each {|v| @image.send(v).class.should == Rubyvis::Scale::Linear}
    end
    
    it "@x and @y should have proper ranges" do
      @image = Bio::Image.new @dataset
      
      @image.send(:x).range.should == [0, @image.width]
      @image.send(:y).range.should == [0, @image.height]
    end
  end
end