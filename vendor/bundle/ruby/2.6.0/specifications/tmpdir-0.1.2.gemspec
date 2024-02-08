# -*- encoding: utf-8 -*-
# stub: tmpdir 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "tmpdir".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "https://github.com/ruby/tmpdir", "source_code_uri" => "https://github.com/ruby/tmpdir" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Yukihiro Matsumoto".freeze]
  s.bindir = "exe".freeze
  s.date = "2021-04-05"
  s.description = "Extends the Dir class to manage the OS temporary file path.".freeze
  s.email = ["matz@ruby-lang.org".freeze]
  s.homepage = "https://github.com/ruby/tmpdir".freeze
  s.licenses = ["Ruby".freeze, "BSD-2-Clause".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Extends the Dir class to manage the OS temporary file path.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fileutils>.freeze, [">= 0"])
    else
      s.add_dependency(%q<fileutils>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<fileutils>.freeze, [">= 0"])
  end
end
