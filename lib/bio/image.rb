module Bio
  class Image
    DEFAULT_HEIGHT = 300
    DEFAULT_WIDTH = 300
    ATTRIBUTES = [:title, :author, :date, :height, :width]
    
    attr_accessor :dataset, *ATTRIBUTES
    
    def initialize dataset, options = {}
      @dataset = dataset
      
      ATTRIBUTES.each { |attr| send("#{attr.to_s}=", options[attr]) }
      
      set_default_options
    end
    
    private
    
    def set_default_options
      @date ||= Time.now
      @height ||= DEFAULT_HEIGHT
      @width ||= DEFAULT_WIDTH
      
      # TODO : size must be enough to fit data
    end
  end
end