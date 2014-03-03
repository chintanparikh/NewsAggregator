require 'feedzirra'
require 'nokogiri'
require 'rest-client'

module ArticlesHelper
  def jaccard_index(n, article_one, article_two)
    first = article_one.split(' ').each_cons(n).to_a
    second = article_two.split(' ').each_cons(n).to_a
    (first & second).length.to_f / ((first.length + second.length).to_f / 2).abs.to_f
  end

  def similar_articles?(threshold, article_one, article_two)
    index = jaccard_index(Article::JACCARD[:n], article_one, article_two) 
    puts index if index > threshold
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

    text = extract_text link, feed.xpath
    return false unless text
    headline = entry.send(feed.headline)
    source = feed.url
    original_id = nil

    # check to see if this article is similar to another
    last_articles.each do |article|
      break if original_id # if we already have a match, break
      threshold = (Feed.find_by_url(article.source).name == feed.name) ? Article::JACCARD[:same_source_threshold] : Article::JACCARD[:threshold]
      original_id = article.get_original.id if similar_articles?(threshold, text, article.text)
    end
    
    puts "#{headline}" unless original_id
    puts "#{headline} (SIMILAR to #{Article.find(original_id).headline})" if original_id

    Article.create(headline: headline, text: text, original_id: original_id, source: source, link: link)
  end

  def extract_text link, xpath 
    doc = Nokogiri::HTML(RestClient.get(link))

    text = doc.search(xpath).to_s
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
