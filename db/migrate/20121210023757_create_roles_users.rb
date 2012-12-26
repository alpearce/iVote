class CreateRolesUsers < ActiveRecord::Migration
  def up
    create_table "roles_users", :id => false, :force => true do |t|
      t.references :user
      t.references :role
      t.timestamps
    end
    
  end

  def down
  end
end
