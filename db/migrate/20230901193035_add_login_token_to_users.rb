class AddLoginTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :login_token
      t.datetime :login_token_expires_at
    end
  end
end
