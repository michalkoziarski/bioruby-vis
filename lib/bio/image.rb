module Bio
  class Image
  
    DEFAULT_VISUALIZE_METHOD = :to_dataset
    
    DEFAULT_HEIGHT = 250
    DEFAULT_WIDTH = 400
    
    ATTRIBUTES = [:title, :date, :height, :width, :top_margin]
    
    attr_reader :left_margin, :right_margin, :top_margin, :bottom_margin, *ATTRIBUTES
    
    def initialize data, options = {}
      @original_data = data
      @data = data
      @options = options
      
      ATTRIBUTES.each { |attr| send("#{attr}=", options[attr]) }
      
      set_default_options
      
      normalize_data
      
      calculate_margins
      
      create_panel options[:parent]
      create_net
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
      @date ||= Time.now
      
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
      x, y = @x, @y
      
      @panel.add(pv.Rule).
        data(@y.ticks).
        bottom(@y).
        stroke_style(lambda {|d| d != 0 ? "#eee" : "#000"}).
        anchor("left").
        add(pv.Label).
          visible(lambda {|d| d != y.ticks.min}).
          text(@y.tick_format)

      @panel.add(pv.Rule).
        data(@x.ticks).
        left(@x).
        stroke_style(lambda {|d| d != 0 ? "#eee" : "#000"}).
        anchor("bottom").
        add(pv.Label).
          visible(lambda {|d| d != x.ticks.min}).
          text(@x.tick_format)
    end
    
  end
end