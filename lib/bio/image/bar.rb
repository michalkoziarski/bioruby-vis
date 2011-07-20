module Bio
  class Image::Bar < Bio::Image
  
    DEFAULT_VISUALIZE_METHOD = :to_dataset
    
    private
    
    def create_image
      x, y = @x, @y
      
      @panel.add(pv.Bar).
        data(@data).
        left(lambda {|d| x.scale(d.x)}).
        height(lambda {|d| y.scale(d.y)}).
        bottom(0).
        width(1).
        anchor("bottom")
    end
    
    def set_default_options
      super
      
      @width = @data[:y].size if @width < @data[:y].size
    end
    
  end
end