module Bio
  class Image
  
    DEFAULT_VISUALIZE_METHOD = nil
    
    DEFAULT_HEIGHT = 250
    DEFAULT_WIDTH = 400
    
    ATTRIBUTES = [:title, :height, :width, :top_margin, :net, :x_labels, :y_labels]
    
    attr_reader :left_margin, :right_margin, :bottom_margin, *ATTRIBUTES
    
    def initialize data, options = {}
      @data = if self.class::DEFAULT_VISUALIZE_METHOD and data.respond_to?(self.class::DEFAULT_VISUALIZE_METHOD)
        data.send(self.class::DEFAULT_VISUALIZE_METHOD)
      else
        data
      end
      
      @original_data = @data
      
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
    
    def save options = {}
      self.jpg.save(options)
    end
    
    file_names = Dir.entries("#{::File.dirname(__FILE__)}/file").select {|file_name| file_name =~ /\.rb/}
    
    extensions = file_names.collect {|file_name| file_name.chomp(".rb")}
    
    (extensions - ["svg"]).each do |extension|
      define_method(extension) do
        eval("Bio::File::#{extension.capitalize}").new(self.svg.to_s)
      end
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
    
    attr_reader :data, :original_data, :options, :x, :y
    
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
	
	  def calculate_extremes
	    [:max, :min].each do |extreme|
	      [:x, :y].each do |value|
		      eval("@#{extreme}_#{value} = @original_data[:#{value}].#{extreme}")
		    end
	    end
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
	    calculate_extremes
	  
      # following line is needed because lambdas won't recognize @x and @y
      x, y, x_l, y_l = @x, @y, @x_labels, @y_labels
	  
	    [:x, :y].each do |sym|
		    eval("
		      #{sym}_ticks = if @#{sym}_labels
			      ticks = Array.new(@#{sym}_labels.size, @min_#{sym})
			      r = Rational (@max_#{sym} - @min_#{sym}), (@#{sym}_labels.size - 1)
			      
			      (@#{sym}_labels.size).times {|i| ticks[i] += i*r}
			      
			      ticks
		      else
			      @#{sym}.ticks
		      end
		  
		      #{sym}_labels = @#{sym}_labels ? lambda { #{sym}_l[self.index] } : @#{sym}.tick_format
		  
		      @panel.add(pv.Rule).
			      data(#{sym}_ticks).
			      #{sym == :x ? 'left' : 'bottom'}(@#{sym}).
			      stroke_style(lambda {|d| d != 0 ? '#eee' : '#000'}).
			      anchor(sym == :x ? 'bottom' : 'left').
			      add(pv.Label).
			        text(#{sym}_labels)
		    ")
	    end
    end
    
    def create_title
      titles_width = @title.size * 6 + 5
      
      @top_margin += 30
      
      @panel.top(@top_margin)
      
      @panel.add(pv.Label).
        left((@width - titles_width) / 2).
        top(17 - @top_margin).
        text(@title)
    end
    
    def create_image; end
    
  end
end