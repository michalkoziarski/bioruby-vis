require 'spec_helper'

describe Bio::Image do
  Bio::Image.send(:attributes).each do |attr|
    it "should be possible to set #{attr} attribute on creating object" do
      @image = Bio::Image.new attr.to_sym => 'value'
      @image.send(attr.to_sym).should == 'value'
    end
  end
  
  it "should set current time on creation" do
    Timecop.freeze
    
    @image = Bio::Image.new
    @image.date.should == Time.now
  end
end