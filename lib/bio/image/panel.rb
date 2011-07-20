module Bio
  class Image::Panel < Bio::Image
    
    def initialize *images
      set_default_options
      
      @panel = pv.Panel.new.
        width(@width).
        height(@height)
        
      images.each {|image| self.add image}
    end
    
    def add image
      image.class.new(image.send(:original_data), image.send(:options).merge(
        :parent => @panel,
        :top_margin => @height + image.send(:top_margin)
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