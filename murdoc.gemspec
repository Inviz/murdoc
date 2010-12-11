# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{murdoc}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Abramov"]
  s.date = %q{2010-12-11}
  s.default_executable = %q{murdoc}
  s.description = %q{Annotated documentation generator, see README.md for details}
  s.email = %q{markizko@gmail.com}
  s.executables = ["murdoc"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "UNLICENSE",
    "VERSION",
    "autotest/discover.rb",
    "bin/murdoc",
    "lib/murdoc.rb",
    "lib/murdoc/annotator.rb",
    "lib/murdoc/formatter.rb",
    "lib/murdoc/languages/javascript.rb",
    "lib/murdoc/languages/ruby.rb",
    "lib/murdoc/paragraph.rb",
    "markup/stylesheet.css",
    "markup/template.haml",
    "murdoc.gemspec",
    "spec/murdoc/annotator_spec.rb",
    "spec/murdoc/formatter_spec.rb",
    "spec/murdoc/paragraph_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/markiz/murdoc}
  s.licenses = ["Public Domain"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Annotated documentation generator}
  s.test_files = [
    "spec/murdoc/annotator_spec.rb",
    "spec/murdoc/formatter_spec.rb",
    "spec/murdoc/paragraph_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rdiscount>, ["~> 1.6.5"])
      s.add_runtime_dependency(%q<haml>, ["~> 3.0.0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_runtime_dependency(%q<haml>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<rdiscount>, ["~> 1.6.5"])
    else
      s.add_dependency(%q<rdiscount>, ["~> 1.6.5"])
      s.add_dependency(%q<haml>, ["~> 3.0.0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_dependency(%q<haml>, ["~> 3.0.0"])
      s.add_dependency(%q<rdiscount>, ["~> 1.6.5"])
    end
  else
    s.add_dependency(%q<rdiscount>, ["~> 1.6.5"])
    s.add_dependency(%q<haml>, ["~> 3.0.0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.1.0"])
    s.add_dependency(%q<haml>, ["~> 3.0.0"])
    s.add_dependency(%q<rdiscount>, ["~> 1.6.5"])
  end
end

