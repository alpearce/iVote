class Vote < ActiveRecord::Base
  attr_accessible :candidate_id, :vote
  belongs_to :ballot
  
  
end
