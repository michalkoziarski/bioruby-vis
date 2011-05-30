module Bio
  class Image::Bar < Bio::Image
    
    TOP_MARGIN = 10
    
    def initialize dataset, options = {}
      super(dataset, options)
      
      if @width < @dataset[:y].size
        @height *= @dataset[:y].size.to_f / @width
        @width = @dataset[:y].size
      end
    end
    
    def svg
      scaled_data = @dataset[:y].scale(@height - TOP_MARGIN)
      
      distance_from_the_bottom = (scaled_data.min > 0 ? 0 : scaled_data.min.abs + TOP_MARGIN / 2)
      
      width_of_bar_and_space = @width / @dataset[:y].size      
      width_of_bar = (width_of_bar_and_space * 0.5).ceil
      width_of_space = width_of_bar_and_space - width_of_bar
      
      left_margin = width_of_space / 2
      
      panel = pv.Panel.new.width(@width).height(@height).margin(20).stroke_style("#ccc")
      
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
      panel.to_svg
    end
    
  end
end