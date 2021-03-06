# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{omniauth}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Michael Bleigh}]
  s.date = %q{2010-04-29}
  s.description = %q{OmniAuth is an authentication framework that that separates the concept of authentiation from the concept of identity, providing simple hooks for any application to have one or multiple authentication providers for a user.}
  s.email = %q{michael@intridea.com}
  s.homepage = %q{http://github.com/intridea/omniauth}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Rack middleware for standardized multi-provider authentication.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oa-core>, ["~> 0.0.0"])
      s.add_runtime_dependency(%q<oa-oauth>, ["~> 0.0.0"])
      s.add_runtime_dependency(%q<oa-openid>, ["~> 0.0.0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<mg>, [">= 0"])
    else
      s.add_dependency(%q<oa-core>, ["~> 0.0.0"])
      s.add_dependency(%q<oa-oauth>, ["~> 0.0.0"])
      s.add_dependency(%q<oa-openid>, ["~> 0.0.0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<mg>, [">= 0"])
    end
  else
    s.add_dependency(%q<oa-core>, ["~> 0.0.0"])
    s.add_dependency(%q<oa-oauth>, ["~> 0.0.0"])
    s.add_dependency(%q<oa-openid>, ["~> 0.0.0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<mg>, [">= 0"])
  end
end
