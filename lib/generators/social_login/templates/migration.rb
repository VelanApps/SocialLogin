class CreateSocialAccounts < ActiveRecord::Migration
  def self.up
     create_table :social_accounts do |t|
      t.string :user_id
      t.string :provider
      t.string :uid
      t.string :account_name

      t.timestamps
    end
  end

  def self.down
    drop_table :social_accounts
  end
end


