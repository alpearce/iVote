class Ballot < ActiveRecord::Base
  attr_accessible :votes
  has_many :votes
  serialize :votes, Array
  
end
