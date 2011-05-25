module Statsample
  class Statsample::Vector
    
    def scale(height)
      current_height = (self.max - [self.min, 0].min).abs.to_f
      ratio = height / current_height
      self.map {|v| v * ratio}
    end
    
  end
end