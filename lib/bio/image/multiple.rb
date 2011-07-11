# TODO : enable labels

module Bio
  class Image::Multiple < Bio::Image
    
    LEGENDS_MARGIN = 25
    
    DEFAULT_COLORS = [
      "#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b", 
      "#e377c2", "#7f7f7f", "#bcbd22", "#aec7e8", "#ffbb78", "#98df8a", 
      "#ff9896", "#c5b0d5", "#c49c94", "#f7b6d2", "#c7c7c7", "#dbdb8d"
    ] 
    
    def initialize *args
      if args[-1].class == Hash
        options = args[-1]
        data = args[0..-2]
      else
        options = {}
        data = args
      end
      
      data.map! {|d| d.respond_to?(:to_dataset) ? d.to_dataset : d}
      
      @max = (data.collect {|d| d[:y].max}).max
      @min = (data.collect {|d| d[:y].min}).min
      
      @size = (data.collect {|d| d[:y].size}).max - 1
      
      @colors = options[:colors] || DEFAULT_COLORS
      
      @legend = options[:legend]
      
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
      @data.each_with_index do |data, index|
        min_diff = data[:y].min - @min
        max_diff = data[:y].max - @max
        
        # TODO : line bellow doesnt work as it should when @max = @min
        
        height_diff = (@max - @min == 0 ? 1 : (data[:y].max - data[:y].min).to_f / (@max - @min))
        
        x = pv.Scale.linear(data[:x].to_a).range(0, @width)
        y = pv.Scale.linear(data[:y].to_a).range(0, height_diff * @height)
        
        color = @colors[index % @colors.size]
        
        case self.class.to_s
        when 'Bio::Image::Timecourse'
          @panel.add(pv.Line).
            stroke_style(color).
            data(data.collect {|d| OpenStruct.new(:x => d[:x], :y => d[:y] + min_diff)}).
            line_width(3).
            left(lambda {|d| x.scale(d.x)}).
            bottom(lambda {|d| y.scale(d.y)}).
            anchor("bottom")
        when 'Bio::Image::Scatterplot'
          @panel.add(pv.Panel).
            data(data.collect {|d| OpenStruct.new(:x => d[:x], :y => d[:y] + min_diff)}).
            add(pv.Dot).
              left(lambda {|d| x.scale(d.x)}).
              bottom(lambda {|d| y.scale(d.y)}).
              shape_size(10).
              stroke_style(color).
              fill_style(color)
        else
          raise "Unsupported class: #{self.class}"
        end
      end
      
      if @legend
        biggest_length = (@legend.collect {|l| l.size}).max
        
        additional_width = biggest_length * 6 + 5
        
        @panel.right(@right_margin + additional_width + LEGENDS_MARGIN)
        
        @legend.each_with_index do |legend, index|
          left = @width + LEGENDS_MARGIN
          top = index * 15
          color = @colors[index % @colors.size]
          
          @panel.add(pv.Dot).
            left(left).
            top(top).
            stroke_style(color).
            fill_style(color).
            add(pv.Label).
              left(left + 5).
              top(top + 7).
              text(legend)
        end
      end
    end
    
    # TODO : total_width
    
  end
end