class Image
  attr_reader :file_name
  
  def initialize file_name
    @file_name = file_name
  end
  
  def path
    "#{Image.dir}/#{self.file_name}"
  end
  
  def self.dir
    "#{File.dirname(__FILE__)}/../../../tmp"
  end
  
  def self.all
    images = []
    
    Dir.entries(Image.dir).each do |path|
      images << Image.new(path) unless path =~ /^\./
    end
    
    images
  end
end
