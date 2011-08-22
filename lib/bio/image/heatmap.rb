module Bio
  class Image::Heatmap < Bio::Image
  
    DEFAULT_VISUALIZE_METHOD = :to_matrix
    
    def scale min, max
      @data = @original_data
      
      @data.each_with_index do |column, i|
        column.each_with_index do |field, j|
          if field > max
            @data[i][j] = max
          end
          
          if field < min
            @data[i][j] = min
          end
        end
      end
      
      Bio::Image::Heatmap.new(@data, @options)
    end
    
    def reset
      Bio::Image::Heatmap.new(@original_data || @data, @options)
    end
    
    private
    
    def set_default_options
      super
      
      @width = 10 * @data.size if @width < 10 * @data.size
      @height = 10 * @data[0].size if @height < 10 * @data[0].size
    end
    
    def calculate_margins
      @top_margin ||= 0
      @right_margin ||= 0
      @bottom_margin ||= 0
      @left_margin ||= 0
      
      @left_margin += (@y_labels.map {|label| label.size}).max * 6 + 5 if @y_labels
      @top_margin += (@x_labels.map {|label| label.size}).max * 6 + 5 if @x_labels
    end
    
    def normalize_data      
      max = min = @data[0][0]
      
      @data.each do |column|
        column.each do |field|
          max = field if field > max
          min = field if field < min
        end
      end
      
      ratio = (max - min).to_f
      
      scaled_min = min / ratio
      
      @data = @data.collect do |column|
        column.collect do |field|
          field / ratio - scaled_min
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
      if @y_labels
        margin = @height.to_f / (2 * @y_labels.size)
        
        @y_labels.each_with_index do |label, index|
          @panel.add(pv.Label).
            top(-10 + @top_margin + margin * (index * 2 + 1)).
            left(-@left_margin).
            text(label)
        end
      end
      
      if @x_labels
        margin = @width.to_f / (2 * @x_labels.size)
        
        @x_labels.each_with_index do |label, index|
          @panel.add(pv.Label).
            top(0).
            left(-10 + @left_margin + margin * (index * 2 + 1)).
            text(label).
            text_angle(-Math::PI / 2.0)
        end
      end
    end
    
    def create_image
      @panel.add(pv.Layout.Grid).
        rows(@data).
        cell.add(pv.Bar).
          fill_style(Rubyvis.ramp("white", "blue"))
    end
    
  end
end