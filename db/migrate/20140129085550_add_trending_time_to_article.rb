class AddTrendingTimeToArticle < ActiveRecord::Migration
  def change
  	add_column :articles, :trending_time, :integer
  end
end
