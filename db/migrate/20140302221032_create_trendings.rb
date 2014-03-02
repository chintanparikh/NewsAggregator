class CreateTrendings < ActiveRecord::Migration
  def change
    create_table :trendings do |t|
      t.integer :article_id	
      t.timestamps
    end
  end
end
