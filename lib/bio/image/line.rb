module Bio
  class Image::Line < Bio::Image
  
    DEFAULT_VISUALIZE_METHOD = :to_dataset
    
    private
    
    def create_image
      x, y = @x, @y
      
      @panel.add(pv.Line).
        data(@data).
        line_width(5).
        left(lambda {|d| x.scale(d.x)}).
        bottom(lambda {|d| y.scale(d.y)}).
        anchor("bottom").
        add(pv.Line).
          stroke_style('red').
          line_width(1)
    end
    
    def set_default_options
      super
      
      @width = @data[:y].size if @width < @data[:y].size
    end
    
  end
end