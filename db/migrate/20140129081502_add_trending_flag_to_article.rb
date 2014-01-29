class AddTrendingFlagToArticle < ActiveRecord::Migration
  def change
  	add_column :articles, :trending, :boolean, default: false
  end
end
