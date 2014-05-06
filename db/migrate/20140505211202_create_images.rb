class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :tag
      t.string :url
      t.timestamps
    end
  end
end
