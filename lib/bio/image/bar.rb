module Bio
  class Image::Bar < Bio::Image
    
    def svg      
      if @width < @dataset[:y].size
        @height *= @dataset[:y].size.to_f / @width
        @width = @dataset[:y].size
      end
      
      scaled_data = @dataset[:y].scale(0, @height)
      
      width_of_bar_and_space = @width / @dataset[:y].size
      
      width_of_bar = (width_of_bar_and_space * 0.5).ceil
      
      panel = pv.Panel.new.width(@width).height(@height)
        
      panel.add(pv.Bar).
        data(scaled_data).
        bottom(0).
        height(lambda {|h| h}).
        width(width_of_bar).
        left(lambda {index * width_of_bar_and_space})
      
      panel.render      
      panel.to_svg
    end
    
  end
end