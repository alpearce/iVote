class Ballot < ActiveRecord::Base
  attr_accessible :votes
  serialize :votes, Hash
  
end
