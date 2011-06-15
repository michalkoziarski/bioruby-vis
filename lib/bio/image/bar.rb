module Bio
  class Image::Bar < Bio::Image
    
    private
    
    def render_image panel, data, x, y     
      panel.add(pv.Bar).
        data(data).
        left(lambda {|d| x.scale(d.x)}).
        height(lambda {|d| y.scale(d.y)}).
        bottom(0).
        width(1).
        anchor("bottom")
    end
    
    def set_default_options
      super
      
      if @width < @data[:y].size
        @width = @data[:y].size
      end
    end
    
  end
end