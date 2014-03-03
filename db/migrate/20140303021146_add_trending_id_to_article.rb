class AddTrendingIdToArticle < ActiveRecord::Migration
  def change
  	add_column :articles, :trending_id, :integer

  end
end
