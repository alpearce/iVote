class CreateBallots < ActiveRecord::Migration
  def change
    create_table :ballots do |t|
      t.text :votes

      t.timestamps
    end
  end
end
