class ArticlesController < ApplicationController
  def index
    @articles = Article.original
  end
end
