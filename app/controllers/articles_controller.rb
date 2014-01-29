class ArticlesController < ApplicationController
  # respond_to :json

  def index
    @articles = Article.original.last(100)
  end

  def after
    @articles = Article.where("id > #{params[:id]}")
    render :index
  end

  def show
    @article = Article.find(params[:id])
  end

  def trending
    @articles = Article.trending
    render :index
  end

  def trending_after
    @articles = Article.trending.where("trending_time > #{params[:time]}")
    render :index
  end
end
