module Bio
  class Image::Bar < Bio::Image
    
    TOP_MARGIN = 10
    
    def svg
      scaled_data = @data[:y].scale(@height - TOP_MARGIN)
      
      distance_from_the_bottom = (scaled_data.min > 0 ? 0 : scaled_data.min.abs + TOP_MARGIN / 2)
      
      width_of_bar_and_space = @width / @data[:y].size      
      width_of_bar = (width_of_bar_and_space * 0.5).ceil
      width_of_space = width_of_bar_and_space - width_of_bar
      
      left_margin = width_of_space / 2
      
      panel = pv.Panel.new.width(@width).height(@height)
      
      panel.add(pv.Rule).
        data([0]).
        bottom(distance_from_the_bottom).
        line_width(2)
        
      panel.add(pv.Bar).
        data(scaled_data).
        bottom(lambda {|d| d > 0 ? distance_from_the_bottom + 1 : distance_from_the_bottom + d - 1}).
        height(lambda {|d| d.abs}).
        width(width_of_bar).
        left(lambda {left_margin + index * width_of_bar_and_space})
      
      panel.render      
      
      Bio::File::Svg.new panel.to_svg
    end
    
    private
    
    def set_default_options
      super
      
      if @width < @data[:y].size
        @width = @data[:y].size
      end
    end
    
  end
end