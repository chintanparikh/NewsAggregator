class RemoveTrendingBooleanField < ActiveRecord::Migration
  def change
  	remove_column :articles, :trending
  end
end
