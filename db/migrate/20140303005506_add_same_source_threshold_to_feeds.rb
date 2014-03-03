class AddSameSourceThresholdToFeeds < ActiveRecord::Migration
  def change
  	add_column :feeds, :same_source_threshold, :float, default: 0.1
  end
end
