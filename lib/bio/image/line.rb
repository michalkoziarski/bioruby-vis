module Bio
  class Image::Line < Bio::Image
    
    def svg
      data = @dataset.collect {|d| OpenStruct.new(:x => d[:x], :y => d[:y])}
      
      x = pv.Scale.linear(@dataset[:x].to_a).range(0, @width)
      y = pv.Scale.linear(@dataset[:y].to_a).range(0, @height)
      
      margin = @width * 0.05
      
      panel = pv.Panel.new.
        width(@width).
        height(@height).
        bottom(margin).
        top(margin)

      panel.add(pv.Line).
        data(data).
        line_width(5).
        left(lambda {|d| x.scale(d.x)}).
        bottom(lambda {|d| y.scale(d.y)}).
        anchor("bottom").
        add(pv.Line).
          stroke_style('red').
          line_width(1)
     

      panel.render
      panel.to_svg
    end
    
  end
end