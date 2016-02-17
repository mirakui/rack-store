Gem::Specification.new do |spec|
  spec.name              = 'rack-store'
  spec.version           = '0.0.4'
  spec.summary           = 'A Rack middleware what makes the env accessible anywhere while a request'
  spec.description       = 'Rack::Store is a Rack middleware what makes the env accessible anywhere while a request'
  spec.files             = Dir.glob("lib/**/*.rb")
  spec.author            = 'Issei Naruta'
  spec.email             = 'naruta@cookpad.com'
  spec.homepage          = 'https://github.com/mirakui/rack-store'
  spec.has_rdoc          = false
  spec.add_dependency 'rack', '>= 1.2.0'
  spec.add_dependency 'activesupport', '>= 3.2.8'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'appraisal', '~> 2.1'
end
