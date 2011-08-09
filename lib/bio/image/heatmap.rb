module Bio
  class Image::Heatmap < Bio::Image
  
    DEFAULT_VISUALIZE_METHOD = :to_matrix
    
    def scale min, max
      @out_of_scale ||= 0
      
      @data.each do |column|
        column.each do |field|
          if field > max
            field = max
            @out_of_scale += 1
          end
          
          if field < min
            field = min
            @out_of_scale += 1
          end
        end
      end
    end
    
    def out_of_scale
      @out_of_scale || 0
    end
    
    def reset
      @data = @original_data if @original_data
    end
    
    private
    
    def set_default_options
      super
      
      @net = false
      
      @width = 10 * @data.size if @width < 10 * @data.size
      @height = 4 * @data[0].size if @height < 4 * @data[0].size
    end
    
    def calculate_margins
      @top_margin ||= 0
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
        left(0).
        top(@top_margin).
        right(0).
        bottom(0)
    end
    
    def create_image
      @panel.add(pv.Layout.Grid).
        rows(@data).
        cell.add(pv.Bar).
          fill_style(Rubyvis.ramp("white", "blue"))
    end
    
  end
end