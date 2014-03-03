namespace :data do
  desc "Add our sources"
  task :add_sources => :environment do
  	# to test
  	# link = "http://rss.cnn.com/rss/money_news_companies.rss"
  	# Feedzirra::Feed.fetch_and_parse(link).entries[0].title
  	# Feedzirra::Feed.fetch_and_parse(link).entries[0].url
  	Feed.create(
  		url: "http://rss.cnn.com/rss/money_news_companies.rss", 
  		entries: "entries",
  		link: "url",
  		headline: "title",
      xpath: "#storytext"
  		)

  	puts "Add http://rss.cnn.com/rss/money_news_companies.rss"

  	Feed.create(
  		url: "http://feeds.marketwatch.com/marketwatch/topstories?format=rss", 
  		entries: "entries",
  		link: "url",
  		headline: "title",
      xpath: "article"
  		)

  	puts "Add http://feeds.marketwatch.com/marketwatch/topstories?format=rss"

  	Feed.create(
  		url: "http://feeds.reuters.com/reuters/companyNews", 
  		entries: "entries",
  		link: "url",
  		headline: "title",
      xpath: "#articleText"
  		)

  	puts "Add http://feeds.reuters.com/reuters/companyNews"

  end

end
