class SocialAccount < ActiveRecord::Base
  attr_accessible :account_name, :provider, :uid, :user_id
  # validates :provider, :presence => true
  # validates :uid, :presence => true
  # validates :account_name, :presence => true
end