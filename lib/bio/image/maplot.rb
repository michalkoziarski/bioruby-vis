module Bio
  class Image::Maplot < Bio::Image::Point
    
    DEFAULT_VISUALIZE_METHOD = nil
    
    def initialize first_sample, second_sample, options = {}
      raise "samples must have the same size" unless first_sample.size == second_sample.size
      
      a, m = [], []
      
      first_sample.size.times do |i|
        first_log = Math::log(first_sample[i], 2)
        second_log = Math::log(second_sample[i], 2)
        
        a << 0.5 * (first_log + second_log)
        m << first_log - second_log
      end
      
      data = Statsample::Dataset.new(:x => a.to_scale, :y => m.to_scale)
      
      super(data, options)
    end
    
  end
end