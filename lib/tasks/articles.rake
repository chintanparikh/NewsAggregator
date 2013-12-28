require 'boilerpipe'
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
end
