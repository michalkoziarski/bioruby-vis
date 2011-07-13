module Bio
  class Image
  
    DEFAULT_VISUALIZE_METHOD = nil
    
    DEFAULT_HEIGHT = 250
    DEFAULT_WIDTH = 400
    
    ATTRIBUTES = [:title, :height, :width, :top_margin, :net, :x_labels, :y_labels]
    
    attr_reader :left_margin, :right_margin, :bottom_margin, *ATTRIBUTES
    
    def initialize data, options = {}
      @original_data = data
      
      @data = if self.class::DEFAULT_VISUALIZE_METHOD and data.respond_to?(self.class::DEFAULT_VISUALIZE_METHOD)
        data.send(self.class::DEFAULT_VISUALIZE_METHOD)
      else
        data
      end
      
      @options = options
      
      ATTRIBUTES.each { |attr| send("#{attr}=", options[attr]) }
      
      set_default_options
      
      normalize_data
      
      calculate_margins
      
      create_panel options[:parent]
      create_net if @net
      create_title if @title
      create_image
    end
    
    def svg
      @panel.render
      
      Bio::File::Svg.new(@panel.to_svg)
    end
    
    def display
      self.svg.display
    end
    
    def jpg
      Bio::File::Jpg.new(self.svg.to_s)
    end
    
    def total_height
      @height + @top_margin + @bottom_margin
    end
    
    def total_width
      @width + @left_margin + @right_margin
    end
    
    private
    
    DEFAULT_RIGHT_MAGIN = 15
    DEFAULT_TOP_MARGIN = 10
    
    attr_writer *ATTRIBUTES
    
    attr_reader :data, :original_data, :options
    
    def set_default_options      
      @net = true if @net.nil?
      
      @height ||= DEFAULT_HEIGHT
      @width ||= DEFAULT_WIDTH
    end
    
    def normalize_data      
      @x = pv.Scale.linear(@data[:x].to_a).range(0, @width)
      @y = pv.Scale.linear(@data[:y].to_a).range(0, @height)
      
      @data = @data.collect {|d| OpenStruct.new(:x => d[:x], :y => d[:y])}
    end
    
    def calculate_margins
      @top_margin ||= DEFAULT_TOP_MARGIN
      @right_margin ||= DEFAULT_RIGHT_MAGIN
      @bottom_margin ||= @height / 20
      
      # TODO : probably the ugliest possible method of calculating margins size, refactor
      @left_margin ||= [
        @y.ticks.min.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1.").size,
        @y.ticks.max.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1.").size
      ].max * 6 + 5
    end
    
    def create_panel parent = nil
      @panel = (parent ? parent.add(pv.Panel) : pv.Panel.new).
        width(@width).
        height(@height).
        left(@left_margin).
        top(@top_margin).
        right(@right_margin).
        bottom(@bottom_margin)
    end
    
    def create_net
      # TODO : following line is needed because lambdas won't recognize @x and @y
      x, y, x_l, y_l = @x, @y, @x_labels, @y_labels
      
      y_ticks = if @y_labels
        ticks = Array.new(@y_labels.size, @original_data[:y].min)
        r = Rational (@original_data[:y].max - @original_data[:y].min), (@y_labels.size - 1)
        
        (@y_labels.size).times {|i| ticks[i] += i*r}
        
        ticks
      else
        @y.ticks
      end
      
      y_labels = @y_labels ? lambda { y_l[self.index] } : @y.tick_format
      
      @panel.add(pv.Rule).
        data(y_ticks).
        bottom(@y).
        stroke_style(lambda {|d| d != 0 ? "#eee" : "#000"}).
        anchor("left").
        add(pv.Label).
          text(y_labels)
          
      x_ticks = if @x_labels
        ticks = Array.new(@x_labels.size, 
        @original_data[:x].min)
        r = Rational (@original_data[:x].max - @original_data[:x].min), (@x_labels.size - 1)
        
        (@x_labels.size).times {|i| ticks[i] += i*r}
        
        ticks
      else
        @x.ticks
      end
      
      x_labels = @x_labels ? lambda { x_l[self.index] } : @x.tick_format

      @panel.add(pv.Rule).
        data(x_ticks).
        left(@x).
        stroke_style(lambda {|d| d != 0 ? "#eee" : "#000"}).
        anchor("bottom").
        add(pv.Label).
          text(x_labels)
    end
    
    def create_title
      titles_width = @title.size * 6 + 5
      
      @top_margin += 30
      
      @panel.top(@top_margin)
      
      @panel.add(pv.Label).
        left((@width - titles_width) / 2).
        top(-13).
        text(@title)
    end
    
  end
end