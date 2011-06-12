module Bio
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
  
    def visualize options = {}
      [:except, :only].each do |option|
        options[option] ||= []      
        options[option] = [options[option]] unless options[option].class == Array
      end
      
      options[:with] ||= {}
    
      file_names = Dir.entries("#{::File.dirname(__FILE__)}/bio/image").select {|file_name| file_name =~ /\.rb/}
      klasses = file_names.collect {|file_name| file_name.chomp ".rb"}
      
      klasses.each do |klass|
        next if options[:except].include? klass.to_sym or (!options[:only].empty? and !options[:only].include? klass.to_sym)
        
        visualize_method = options[:with][klass.to_sym] || eval("Bio::Image::#{klass.capitalize}::DEFAULT_VISUALIZE_METHOD")
        
        self.send :define_method, "to_#{klass}" do |options = {}|
          eval("Bio::Image::#{klass.capitalize}").new(self.send(visualize_method), options)
        end
      end
      
    end
  end
end