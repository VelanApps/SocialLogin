# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "social_login"
  s.summary = "Create Social Login with Twitter,Facebook adn LinkedIn"
  s.authors       = ["Velan Info Services"]
  s.email         = "vispl.dev@gmail.com"
  s.description   = "Social Accounts Creation"
  s.files         = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version       = "0.0.1"
  s.require_path  = "lib"
  s.license       = "MIT"
  s.homepage      = "https://github.com/VelanApps/SocialLogin/"
  s.add_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'devise'
  s.add_runtime_dependency 'omniauth'
  s.add_runtime_dependency 'omniauth-twitter'
  s.add_runtime_dependency 'omniauth-facebook'
  s.add_runtime_dependency 'omniauth-linkedin'
  s.add_runtime_dependency 'rspec-rails', '~> 2.5'
end