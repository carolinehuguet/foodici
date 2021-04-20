# -*- encoding: utf-8 -*-
# stub: stripe_event 2.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "stripe_event".freeze
  s.version = "2.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Danny Whalen".freeze]
  s.date = "2020-05-12"
  s.description = "Stripe webhook integration for Rails applications.".freeze
  s.email = "daniel.r.whalen@gmail.com".freeze
  s.homepage = "https://github.com/integrallis/stripe_event".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Stripe webhook integration for Rails applications.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.1"])
      s.add_runtime_dependency(%q<stripe>.freeze, [">= 2.8", "< 6"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.7"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1.9"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 3.1"])
      s.add_dependency(%q<stripe>.freeze, [">= 2.8", "< 6"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.7"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1.9"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.1"])
    s.add_dependency(%q<stripe>.freeze, [">= 2.8", "< 6"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.7"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.9"])
  end
end
