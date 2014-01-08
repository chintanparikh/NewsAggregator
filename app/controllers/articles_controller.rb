class ArticlesController < ApplicationController
  respond_to :json, :xml
  def index
    @articles = Article.original.last(100)
  end

  def after
    #params[:id]
  end
end
