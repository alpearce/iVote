class UserVoted < ActiveRecord::Base
  attr_accessible :user_id, :voted
end
