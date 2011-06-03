module Bio
  class Image::Point < Bio::Image
    
    # TODO : unify svg methods, move repeating code to Bio::Image
    
    def svg      
      data = @dataset.collect {|d| OpenStruct.new(:x => d[:x], :y => d[:y])}
      
      x = pv.Scale.linear(@dataset[:x].to_a).range(0, @width)
      y = pv.Scale.linear(@dataset[:y].to_a).range(0, @height)
      
      # TODO : probably the ugliest possible method of calculating margins size, refactor
      left_margin = [
        y.ticks.min.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1.").size,
        y.ticks.max.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1.").size
      ].max * 6 + 5
      
      panel = pv.Panel.new.
        width(@width).
        height(@height).
        left(left_margin).
        top(10).
        right(15).
        bottom(@height / 20)
        
      panel.add(pv.Rule).
        data(y.ticks).
        bottom(y).
        stroke_style(lambda {|d| d != 0 ? "#eee" : "#000"}).
        anchor("left").
        add(pv.Label).
          visible(lambda {|d|  d != y.ticks.min}).
          text(y.tick_format)

      panel.add(pv.Rule).
        data(x.ticks).
        left(x).
        stroke_style(lambda {|d| d != 0 ? "#eee" : "#000"}).
        anchor("bottom").
        add(pv.Label).
          visible(lambda {|d|  d != x.ticks.min}).
          text(x.tick_format)

      panel.add(pv.Panel).
        data(data).
        add(pv.Dot).
          left(lambda {|d| x.scale(d.x)}).
          bottom(lambda {|d| y.scale(d.y)}).
          shape_size(10).
          stroke_style("#7375b5").
          fill_style("#7375b5")
     

      panel.render
      
      Bio::File::Svg.new panel.to_svg
    end
    
  end
end