class AddFileModificationTimeToImages < ActiveRecord::Migration
  def change
    add_column :images, :file_modification_time, :datetime
  end
end
