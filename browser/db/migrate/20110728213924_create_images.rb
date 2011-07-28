class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.column :path, :string
      t.column :image, :string
      t.timestamps
    end
  end
end
