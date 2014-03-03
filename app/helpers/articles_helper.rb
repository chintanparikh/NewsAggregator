require 'embedly'
require 'feedzirra'
require 'pismo'


module ArticlesHelper
  def jaccard_index(n, article_one, article_two)
    first = article_one.split(' ').each_cons(n).to_a
    second = article_two.split(' ').each_cons(n).to_a
    (first & second).length.to_f / ((first.length + second.length).to_f / 2).abs.to_f
  end

  def similar_articles?(same, article_one, article_two)
    index = jaccard_index(Article::JACCARD[:n], article_one, article_two) 
    threshold = (same ? Article::JACCARD[:same_source_threshold] : Article::JACCARD[:threshold])
    index > threshold
  end

  def pull feeds, last_articles
    feeds.each do |feed|
      puts "Pulling from #{feed.url}"
      last_from_source = Article.where(source: feed.url).limit(100) || []
      rss = Feedzirra::Feed.fetch_and_parse(feed.url)

      entries = rss.send(feed.entries)
      
      entries.each do |entry|
        article = create_article feed, entry, last_from_source, last_articles
        if article
          last_articles << article
          last_from_source << article

          original = article.get_original
          if original.should_be_trending? and !original.is_trending?
            puts "TRENDING TRENDING TRENDING"
            original.set_trending!
          end
        end
      end
    end
  end

  def create_article feed, entry, last_from_source, last_articles
    link = entry.send(feed.link)
    
    #ensure we don't re-create an entry
    last_from_source.each do |entry|
      return false if link == entry.link
    end

    text = extract_text link
    return false unless text
    headline = entry.send(feed.headline)
    source = feed.url
    original_id = nil

    # check to see if this article is similar to another
    last_articles.each do |article|
      break if original_id
      same_source = (article.source == source)
      original_id = article.get_original.id if similar_articles?(same_source, text, article.text)
    end
    
    puts "#{headline}" unless original_id
    puts "#{headline} (SIMILAR to #{Article.find(original_id).headline})" if original_id

    Article.create(headline: headline, text: text, original_id: original_id, source: source, link: link)
  end

  def extract_text link 
    # embedly = Embedly::API.new key: "23a1325f5ed547e7acb45276821e4fad"
    # response = embedly.extract url: link
    # text = response[0].content 
    # # Remove all tags
    # text = ActionView::Base.full_sanitizer.sanitize(text)
    doc = Pismo::Document.new(link)

    text = doc.body
    text = ActionView::Base.full_sanitizer.sanitize(text)
    
    return nil unless text
    # Remove all apostrophes
    text.gsub!(/\'/, '')
    # Replace all non alpha-numeric characters with a space
    text.gsub!(/[^a-zA-Z0-9\s]/, ' ')
    # Turn all whitespace into a single space`
    text.gsub!(/\s+/, ' ')
    text
  end  
end
