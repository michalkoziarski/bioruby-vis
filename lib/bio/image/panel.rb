module Bio
  class Image::Panel < Bio::Image
    
    DEFAULT_VISUALIZE_METHOD = nil
    
    def initialize
      set_default_options
      
      @panel = pv.Panel.new.
        width(@width).
        height(@height)
    end
    
    def add image
      image.class.new(image.send(:original_data), image.send(:options).merge(
        :parent => @panel,
        :top_margin => @height
      ))
      
      @width = [image.total_width, @width].max
      @height += image.total_height
      
      @panel.width(@width).height(@height)
    end
    
    def svg
      @panel.render
      
      Bio::File::Svg.new(@panel.to_svg)
    end
    
    private
    
    def set_default_options      
      @height = @width = 0
    end
    
  end
end