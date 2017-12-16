class CreateCategoryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :category_items do |t|
      t.belongs_to :item, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
