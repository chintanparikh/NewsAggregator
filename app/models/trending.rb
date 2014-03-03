class Trending < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :article_id

  has_one :article

  after_create :set_trending_id_on_article

  def set_trending_id_on_article
  	article = Article.find_by_id(self.article_id)
  	article.trending_id = self.id
  	article.save
  end
end
