class CreateTrendingTable < ActiveRecord::Migration
	def change
		create_table :trending do |t|
			t.integer :article_id
		end
	end
end
