module Bio
  class Image::Point < Bio::Image
    
    private
    
    def render_image panel, data, x, y
      panel.add(pv.Panel).
        data(data).
        add(pv.Dot).
          left(lambda {|d| x.scale(d.x)}).
          bottom(lambda {|d| y.scale(d.y)}).
          shape_size(10).
          stroke_style("#7375b5").
          fill_style("#7375b5")
    end
    
    def set_default_options
      super
      
      if @width < @data[:y].size
        @height *= @data[:y].size.to_f / @width
        @width = @data[:y].size
      end
    end
    
  end
end