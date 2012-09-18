class CreateUserVoteds < ActiveRecord::Migration
  def change
    create_table :user_voteds do |t|
      t.integer :user_id
      t.boolean :voted

      t.timestamps
    end
  end
end
