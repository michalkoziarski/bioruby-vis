require 'statsample'
require 'rubyvis'
require 'bio'
require 'require_all'
require 'RMagick'
require 'bio-samtools'

require_all File.dirname(__FILE__)

# TODO : find a better place for Array class

class Array
  include Bio
  
  visualize
  
  def to_dataset
    Statsample::Dataset.new(:x => (0...self.size).to_a.to_scale, :y => self.to_scale)
  end
end