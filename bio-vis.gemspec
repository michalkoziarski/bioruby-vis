# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bio-vis}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["e-mka"]
  s.date = %q{2011-08-13}
  s.description = %q{Bio-vis is a gem designed to enable visualization of biological data.}
  s.email = %q{michal.koziarski@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bio-vis.gemspec",
    "lib/bio-vis.rb",
    "lib/bio.rb",
    "lib/bio/file.rb",
    "lib/bio/file/bmp.rb",
    "lib/bio/file/gif.rb",
    "lib/bio/file/jpg.rb",
    "lib/bio/file/svg.rb",
    "lib/bio/image.rb",
    "lib/bio/image/bar.rb",
    "lib/bio/image/heatmap.rb",
    "lib/bio/image/line.rb",
    "lib/bio/image/maplot.rb",
    "lib/bio/image/multiple.rb",
    "lib/bio/image/panel.rb",
    "lib/bio/image/point.rb",
    "lib/bio/image/scatterplot.rb",
    "lib/bio/image/timecourse.rb",
    "spec/bio/image/bar_spec.rb",
    "spec/bio/image/heatmap_spec.rb",
    "spec/bio/image/line_spec.rb",
    "spec/bio/image/panel_spec.rb",
    "spec/bio/image/point_spec.rb",
    "spec/bio/image_spec.rb",
    "spec/spec_helper.rb",
    "tmp/.gitkeep"
  ]
  s.homepage = %q{http://github.com/e-mka/bioruby-vis}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Visualization library for BioRuby}
  s.test_files = [
    "spec/bio/image/bar_spec.rb",
    "spec/bio/image/heatmap_spec.rb",
    "spec/bio/image/line_spec.rb",
    "spec/bio/image/panel_spec.rb",
    "spec/bio/image/point_spec.rb",
    "spec/bio/image_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubyvis>, [">= 0"])
      s.add_runtime_dependency(%q<statsample>, [">= 0"])
      s.add_runtime_dependency(%q<bio>, [">= 1.4.1"])
      s.add_runtime_dependency(%q<require_all>, [">= 0"])
      s.add_runtime_dependency(%q<rmagick>, [">= 0"])
      s.add_runtime_dependency(%q<bio-samtools>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.5.0"])
    else
      s.add_dependency(%q<rubyvis>, [">= 0"])
      s.add_dependency(%q<statsample>, [">= 0"])
      s.add_dependency(%q<bio>, [">= 1.4.1"])
      s.add_dependency(%q<require_all>, [">= 0"])
      s.add_dependency(%q<rmagick>, [">= 0"])
      s.add_dependency(%q<bio-samtools>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<rubyvis>, [">= 0"])
    s.add_dependency(%q<statsample>, [">= 0"])
    s.add_dependency(%q<bio>, [">= 1.4.1"])
    s.add_dependency(%q<require_all>, [">= 0"])
    s.add_dependency(%q<rmagick>, [">= 0"])
    s.add_dependency(%q<bio-samtools>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.5.0"])
  end
end

