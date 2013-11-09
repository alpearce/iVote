class AddVotedAlreadyToProxy < ActiveRecord::Migration
  def change
    add_column :proxies, :voted_already, :boolean
  end
end
