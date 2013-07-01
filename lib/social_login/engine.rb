require 'devise'
require 'omniauth'
require 'omniauth-twitter'
require 'omniauth-facebook'
require 'omniauth-linkedin'
require 'rails/generators'
require 'rails/generators/migration'
module SocialLogin
  class Engine < ::Rails::Engine
    isolate_namespace SocialLogin
  end
end