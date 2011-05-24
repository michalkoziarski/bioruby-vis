module Statsample
  class Statsample::Vector
    
    # TODO : scaling doesn't work as it should
    
    def scale(min, max)
      min_before = self.min
      scaled = self.map {|v| v - min_before + min}
      max_before = scaled.max
      scaled.map {|v| v * max / max_before.to_f}
    end
  end
end