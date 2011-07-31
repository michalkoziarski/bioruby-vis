require 'RMagick'

class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  has_and_belongs_to_many :tags
  
  validates_presence_of :path
  
  attr_accessible :path
  
  after_create :upload_image
  
  before_create :set_file_modification_time
  
  def self.dir
    "#{File.dirname(__FILE__)}/../../../tmp"
  end
  
  def self.reload_images    
    entries = Dir.new(Image.dir).entries.reject {|entry| entry =~ /^\./}
    
    entries.each do |entry|
      image = Image.find_by_path(entry)
      if !image
        Image.create(:path => entry)
      elsif image.file_modification_time.utc.to_s != File.mtime("#{Image.dir}/#{entry}").utc.to_s
        image.destroy
        Image.create(:path => entry)
      end
    end
  end
  
  def full_path
    "#{Image.dir}/#{self.path}"
  end
  
  def perm_destroy
    File.delete(self.full_path)
    
    self.destroy
  end
  
  private
  
  def upload_image
    image_file = File.open(self.full_path)
    
    self.image.store!(image_file)
    self.save
  end
  
  def set_file_modification_time
    self.file_modification_time = File.mtime(self.full_path)
  end
end
