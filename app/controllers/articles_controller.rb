class ArticlesController < ApplicationController
  respond_to :json, :xml
  
  def index
    @articles = Article.original
  end
end
