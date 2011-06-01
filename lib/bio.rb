module Bio
  
  # TODO : bellow code doesn't work, it is executed only once, in the module itsef.
  # Find a way of executing it every time it's included
  
  if self.respond_to? :to_dataset
    file_names = Dir.entries("#{File.dirname(__FILE__)}/bio/image").select {|file_name| file_name =~ /\.rb/}
    classes = file_names.collect {|file_name| file_name.slice! ".rb"}
    
    classes.each do |c|
      define_method "to_#{c}" do |options = {}|
        eval("Bio::Image::#{c.capitalize}").new(self.to_dataset, options)
      end
    end
  end
  
end