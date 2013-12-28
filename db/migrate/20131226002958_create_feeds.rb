class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :entries
      t.string :link
      t.string :headline

      t.timestamps
    end
  end
end
