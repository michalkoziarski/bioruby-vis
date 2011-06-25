module Bio
  class Image
  
    DEFAULT_VISUALIZE_METHOD = :to_dataset
    
    DEFAULT_HEIGHT = 250
    DEFAULT_WIDTH = 400
    
    ATTRIBUTES = [:title, :author, :date, :height, :width]
    
    attr_accessor *ATTRIBUTES
    
    def initialize data, options = {}
      @data = data
      
      ATTRIBUTES.each { |attr| send("#{attr}=", options[attr]) }
      
      set_default_options
      
      normalize_data
    end
    
    def svg
      create_panel
      
      create_net

      create_image

      @panel.render
      
      Bio::File::Svg.new(@panel.to_svg)
    end
    
    def display
      self.svg.display
    end
    
    def jpg
      Bio::File::Jpg.new(self.svg.to_s)
    end
    
    private
    
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
    
    def left_margin
      # TODO : probably the ugliest possible method of calculating margins size, refactor
      left_margin = [
        @y.ticks.min.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1.").size,
        @y.ticks.max.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1.").size
      ].max * 6 + 5
    end
    
    def create_panel
      @panel = pv.Panel.new.
        width(@width).
        height(@height).
        left(left_margin).
        top(10).
        right(15).
        bottom(@height / 20)
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