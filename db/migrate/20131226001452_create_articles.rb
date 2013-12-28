class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :headline
      t.text :text
      t.boolean :parent
      t.integer :original_id

      t.timestamps
    end
  end
end
