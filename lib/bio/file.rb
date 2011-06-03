module Bio
  class File
    
    @@default_dir = "#{::File.dirname(__FILE__)}/../../tmp"
    
    def self.default_dir
      @@default_dir
    end
      
    def self.default_dir= dir
      @@default_dir = dir
    end
    
  end
end