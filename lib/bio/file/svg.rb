module Bio
  class File::Svg < Bio::File
    
    def initialize content
      @content = content
    end
    
    def to_s
      @content
    end
    
    def save options = {}
      super(options)
      
      ::File.open(@path, "w+") do |f|
        f.puts @content
      end
    end
    
  end
end