class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :max_yes
      t.integer :max_abs

      t.timestamps
    end
  end
end
