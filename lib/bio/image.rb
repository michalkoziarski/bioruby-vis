module Bio
  class Image
  
    DEFAULT_VISUALIZE_METHOD = :to_dataset
    
    DEFAULT_HEIGHT = 250
    DEFAULT_WIDTH = 400
    
    ATTRIBUTES = [:title, :author, :date, :height, :width]
    
    attr_accessor :data, *ATTRIBUTES
    
    def initialize data, options = {}
      @data = data
      
      ATTRIBUTES.each { |attr| send("#{attr}=", options[attr]) }
      
      set_default_options
    end
    
    def display
      self.svg.display
    end
    
    def jpg
      Bio::File::Jpg.new(self.svg.to_s)
    end
    
    private
    
    def set_default_options
      @date ||= Time.now
      
      @height ||= DEFAULT_HEIGHT
      @width ||= DEFAULT_WIDTH
    end
    
  end
end