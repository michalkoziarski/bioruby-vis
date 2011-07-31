class CreateImagesTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :images_tags, :id => false do |t|
      t.column :image_id, :integer
      t.column :tag_id, :integer
    end
  end
end
