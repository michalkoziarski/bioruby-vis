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
      klass = image.class
      data = image.send(:original_data)
      options = image.send(:options).merge(
        :parent => @panel,
        :top_margin => @height + image.send(:top_margin)
      )
      
      if klass.ancestors.include? Bio::Image::Multiple
        klass.new(*data, options)
      else
        klass.new(data, options)
      end
      
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