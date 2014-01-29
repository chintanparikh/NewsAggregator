class Article < ActiveRecord::Base
  attr_accessible :headline, :original_id, :text, :link, :source
  has_many :similar_articles, class_name: "Article", foreign_key: "original_id"
  belongs_to :original, class_name: "Article"

  JACCARD = {threshold: 0.02, same_source_threshold: 0.04, n: 3}
  TRENDING_THRESHOLD = 1

  scope :original, -> { where(original_id: nil) }

  def is_original? 
    original_id == nil
  end

  def get_original
    return self if is_original?
    return Article.find(original_id)
  end
end
