require "active_support/dependencies"
module SocialLogin
  mattr_accessor :app_root
  def self.setup
    yield self
  end
end
require "social_login/engine"
