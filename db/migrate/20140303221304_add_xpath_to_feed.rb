class AddXpathToFeed < ActiveRecord::Migration
  def change
  	add_column :feeds, :xpath, :string
  end
end
