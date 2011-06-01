module Bio
  class Image
    
    include Magick
    
    DEFAULT_HEIGHT = 300
    DEFAULT_WIDTH = 300
    
    ATTRIBUTES = [:title, :author, :date, :height, :width]
    
    attr_accessor :dataset, *ATTRIBUTES
    
    def initialize dataset, options = {}
      @dataset = dataset
      
      ATTRIBUTES.each { |attr| send("#{attr}=", options[attr]) }
      
      set_default_options
      
      if @width < @dataset[:y].size
        @height *= @dataset[:y].size.to_f / @width
        @width = @dataset[:y].size
      end
    end
    
    def display
      # TODO : classes responsible for handling files must be created,
      # generic Bio::File ( Bio::Image::File? ) should allow change of
      # storage directory, it should also be possible to override
      # it only for a single file
      
      path = "#{File.dirname(__FILE__)}/../../tmp/#{self.class.to_s.split('::').last}_#{Time.now.to_i}.svg"
      
      File.open(path, "w+") do |f|
        f.puts self.svg
      end
      
      ImageList.new(path).display
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