module Bio
  class File::Svg < Bio::File
    
    include Magick
    
    def initialize content
      @content = content
    end
    
    def to_s
      @content
    end
    
    def display
      self.save
      
      ImageList.new(@path).display
    end
    
    def save options = {}
      @dir = options[:dir] || @dir || self.class.default_dir
      @name = options[:name] || @name || "Untitled(#{Time.now.to_i})"
      @path = options[:path] || "#{@dir.chomp('/')}/#{@name}.svg"
      
      ::File.open(@path, "w+") do |f|
        f.puts @content
      end
    end
    
  end
end