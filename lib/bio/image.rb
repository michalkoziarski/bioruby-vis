module Bio
  class Image
    private
    
    def self.attributes
      [:title, :author, :date, :height, :width]
    end
    
    public
    
    attr_accessor *self.attributes
    
    def initialize options = {}
      @date = Time.now
      
      self.class.attributes.each {|attr| send("#{attr.to_s}=", options[attr])}
    end
  end
end