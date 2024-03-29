class Article < ActiveRecord::Base
  attr_accessible :headline, :original_id, :text, :link, :source, :trending, :trending_time
  has_many :similar_articles, class_name: "Article", foreign_key: "original_id"
  belongs_to :original, class_name: "Article"

  belongs_to :trending

  JACCARD = {threshold: 0.05, same_source_threshold: 0.15 , n: 3}
  TRENDING_THRESHOLD = 1

  scope :original, -> { where(original_id: nil) }
  scope :trending, -> { where(trending: true) }

  def is_original? 
    original_id == nil
  end

  def should_be_trending?
    similar_articles.count >= TRENDING_THRESHOLD
  end

  def is_trending?
    trending_id != nil
  end

  def set_trending!
    update_attributes(trending_time: DateTime.now.to_i)
    Trending.create(article_id: id)
  end

  def get_original
    return self if is_original?
    return Article.find(original_id)
  end
end
