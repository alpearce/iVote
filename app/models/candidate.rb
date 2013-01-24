class Candidate < ActiveRecord::Base
  attr_accessible :image_url, :name, :picture
  
  has_attached_file :picture
  
end
