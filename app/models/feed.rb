class Feed < ActiveRecord::Base
  attr_accessible :entries, :headline, :link, :url
end
