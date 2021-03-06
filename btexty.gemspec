# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{btexty}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Turner"]
  s.date = %q{2009-05-12}
  s.email = %q{mark@amerine.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "btexty.gemspec",
     "lib/btexty.rb",
     "lib/btexty/data.rb",
     "test/btexty_test.rb",
     "test/fixtures/messages.json",
     "test/fixtures/unread.json",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/amerine/btexty}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{super simple ruby interface for the btexty api}
  s.test_files = [
    "test/btexty_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
