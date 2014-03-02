class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :api_key
      t.datetime :last_accessed

      t.timestamps
    end
  end
end
