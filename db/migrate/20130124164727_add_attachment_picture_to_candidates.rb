class AddAttachmentPictureToCandidates < ActiveRecord::Migration
  def self.up
    change_table :candidates do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :candidates, :picture
  end
end
