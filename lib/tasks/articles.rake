require 'feedzirra'
require "#{Rails.root}/app/helpers/articles_helper"
include ArticlesHelper

namespace :articles do
  desc "Pulls in new articles from the feeds"
  task :pull => :environment do
    puts "Pulling new articles"
    
    feeds = Feed.all
    last_articles = Article.last(100)|| []
    
    pull feeds, last_articles
  end

  desc "Removes old articles from the database"
  task :cleanup => :environment do
  	# For each article
  		# If article isn't head of a chain, delete it
  		# If article is head of a chain, switch head to last element, then delete (or just delete if no elements left)
  	Article.where("created_at < ?", DateTime.now - 1.day).each do |article|
  		if article.similar_articles.empty?
  		    article.destroy! 	
  		else
			new_original = article.similar_articles.last
			article.similar_articles.each do |similar|
				similar.original_id = new_original.id
			end	  
			new_original.original_id = nil
			article.destroy! 	
  		end
  	end	
  end
end
