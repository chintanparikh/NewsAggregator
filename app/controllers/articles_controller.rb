class ArticlesController < ApplicationController
  respond_to :json, :xml

  def index
    @articles = Article.original.last(100)
  end

  def after
    @articles = Article.where("id > #{params[:id]}")
  end

  def show
    @article = Article.find(params[:id])
  end
end
