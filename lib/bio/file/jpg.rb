module Bio
  class File::Jpg < Bio::File
    
    def initialize svg
      @svg = svg
    end
    
    def save options = {}
      super(options)
      
      svg_path = @path.sub Regexp.new("#{self.class.to_s.split('::').last.downcase}"), 'svg'
      
      svg_file = ::File.open(svg_path, "w+")
      svg_file.puts @svg
      svg_file.close
      
      ImageList.new(svg_path).write(@path)
      
      ::File.delete(svg_file)
    end
    
  end
end