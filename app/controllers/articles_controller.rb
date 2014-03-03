class ArticlesController < ApplicationController
  # respond_to :json
  before_filter :get_client

  def get_client
    @client = Client.find_by_api_key(params[:api_key])
  end

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
    @articles = Trending.map{|trending| trending.article}
    @client.accessed!
    render :index
  end

  def trending_after
    @articles = Article.trending.where("trending_time > #{params[:time]}")
    render :index
  end

  def trending_new
    if @client.last_accessed == nil
      @articles = Trending.all.map{|trending| trending.article}
    else
      @articles = Trending.where("created_at > ?", @client.last_accessed).map{|trending| trending.article}
    end

    @client.accessed!
    render :index
  end
end
