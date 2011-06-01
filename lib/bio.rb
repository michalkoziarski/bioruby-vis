module Bio
  
  def initialize  
    if self.respond_to? :to_dataset
      file_names = Dir.entries("#{File.dirname(__FILE__)}/bio/image").select {|file_name| file_name =~ /\.rb/}
      classes = file_names.collect {|file_name| file_name.chomp ".rb"}
      
      classes.each do |c|
        unless self.respond_to? "to_#{c}"
          self.class.send :define_method, "to_#{c}" do |options = {}|
            eval("Bio::Image::#{c.capitalize}").new(self.to_dataset, options)
          end
        end
      end
      
    end
  end
  
end