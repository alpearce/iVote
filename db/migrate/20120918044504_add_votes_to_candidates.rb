class AddVotesToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :yes, :integer
    add_column :candidates, :no, :integer
    add_column :candidates, :abstain, :integer
    
    
  end
end
