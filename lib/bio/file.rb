module Bio
  class File < ::File
    
    include Magick
    
    attr_reader :path
    
    @@default_dir = "#{::File.dirname(__FILE__)}/../../tmp"
    
    def self.default_dir
      @@default_dir
    end
      
    def self.default_dir= dir
      @@default_dir = dir
    end
    
    def display
      self.save
      
      ImageList.new(@path).display
    end
    
    def save options = {}
      @dir = options[:dir] || @dir || self.class.default_dir
      @name = options[:name] || @name || "Untitled(#{Time.now.to_i})"
      
      extension = self.class.to_s.split('::').last.downcase
      
      @path = options[:path] || "#{@dir.chomp('/')}/#{@name}.#{extension}"
      @path += ".#{extension}" unless @path =~ /#{extension}$/i
    end
    
  end
end
