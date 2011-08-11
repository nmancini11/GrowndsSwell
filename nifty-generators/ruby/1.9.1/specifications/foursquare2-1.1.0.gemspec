# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{foursquare2}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Matt Mueller}, %q{Marco Moura}]
  s.date = %q{2011-05-25}
  s.description = %q{Gives access to all endpoints in version 2 of foursquare's API with syntax that will be familiar to those who used the original foursquare gem by Jeremy Welch.}
  s.email = [%q{muellermr@gmail.com}, %q{email@marcomoura.com}]
  s.extra_rdoc_files = [%q{LICENSE.txt}]
  s.files = [%q{LICENSE.txt}]
  s.homepage = %q{http://github.com/mattmueller/foursquare2}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Foursquare API v2 gem in the spirit of the original foursquare gem}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, ["~> 0.6"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.6"])
      s.add_runtime_dependency(%q<hashie>, ["~> 1.0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, ["~> 1.3"])
      s.add_development_dependency(%q<jnunemaker-matchy>, ["~> 0.4"])
      s.add_development_dependency(%q<json_pure>, ["~> 1.4"])
      s.add_development_dependency(%q<multi_json>, ["< 2.0.0", ">= 0.0.5"])
    else
      s.add_dependency(%q<faraday>, ["~> 0.6"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.6"])
      s.add_dependency(%q<hashie>, ["~> 1.0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<fakeweb>, ["~> 1.3"])
      s.add_dependency(%q<jnunemaker-matchy>, ["~> 0.4"])
      s.add_dependency(%q<json_pure>, ["~> 1.4"])
      s.add_dependency(%q<multi_json>, ["< 2.0.0", ">= 0.0.5"])
    end
  else
    s.add_dependency(%q<faraday>, ["~> 0.6"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.6"])
    s.add_dependency(%q<hashie>, ["~> 1.0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<fakeweb>, ["~> 1.3"])
    s.add_dependency(%q<jnunemaker-matchy>, ["~> 0.4"])
    s.add_dependency(%q<json_pure>, ["~> 1.4"])
    s.add_dependency(%q<multi_json>, ["< 2.0.0", ">= 0.0.5"])
  end
end
