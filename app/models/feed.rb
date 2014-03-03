class Feed < ActiveRecord::Base
  attr_accessible :entries, :headline, :link, :url, :same_source_threshold
end
