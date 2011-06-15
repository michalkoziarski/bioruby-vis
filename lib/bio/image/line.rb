module Bio
  class Image::Line < Bio::Image
    
    private
    
    def render_image panel, data, x, y
      panel.add(pv.Line).
        data(data).
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
      
      if @width < @data[:y].size
        @width = @data[:y].size
      end
    end
    
  end
end