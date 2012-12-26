class Proxies < ActiveRecord::Migration
  def up
    add_column :users, :proxy_id, :integer
  end

  def down
    remove_column :user, :proxy_id
  end
end
