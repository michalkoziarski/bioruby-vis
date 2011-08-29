class Array
  include Bio
  
  visualize
  
  def to_dataset
    Statsample::Dataset.new(:x => (0...self.size).to_a.to_scale, :y => self.to_scale)
  end
end

class Statsample::Dataset
  include Bio
  
  visualize
  
  def to_dataset
    self
  end
end
