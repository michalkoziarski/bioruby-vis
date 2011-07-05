module Bio
  class Image::Scatterplot < Bio::Image
    
    DEFAULT_VISUALIZE_METHOD = nil
    
    def initialize *args
      if args[-1].class == Hash
        options = args[-1]
        data = args[0..-2]
      else
        options = {}
        data = args
      end
      
      @max = (data.collect {|d| d[:y].max}).max
      @min = (data.collect {|d| d[:y].min}).min
      
      @size = (data.collect {|d| d[:y].size}).max - 1
      
      super(data, options)
    end
    
    private
    
    def set_default_options
      super
      
      @width = @size if @width < @size
    end
    
    def normalize_data      
      @x = pv.Scale.linear([0, @size]).range(0, @width)
      @y = pv.Scale.linear([@min, @max]).range(0, @height)
    end
    
    def create_image
      @data.each do |data|
        min_diff = data[:y].min - @min
        max_diff = data[:y].max - @max
        
        height_diff = (@max - @min == 0 ? 1 : (data[:y].max - data[:y].min).to_f / (@max - @min))
        
        x = pv.Scale.linear(data[:x].to_a).range(0, @width)
        y = pv.Scale.linear(data[:y].to_a).range(0, height_diff * @height)
      
        @panel.add(pv.Panel).
          data(data.collect {|d| OpenStruct.new(:x => d[:x], :y => d[:y] + min_diff)}).
          add(pv.Dot).
            left(lambda {|d| x.scale(d.x)}).
            bottom(lambda {|d| y.scale(d.y)}).
            shape_size(10).
            stroke_style("#7375b5").
            fill_style("#7375b5")
      end
    end
    
  end
end