class Trending < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :article_id

  has_one :article
end
