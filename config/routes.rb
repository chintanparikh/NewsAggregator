ArticleAggregator::Application.routes.draw do
  resources :articles, defaults: {format: :json}
  # This is disgusting, but I couldn't find a better way to do it :(
  get '/:api_key/articles/after/:id', to: 'articles#after', defaults: {format: :json}
  get '/:api_key/articles/trending', to: "articles#trending", defaults: {format: :json}
  get '/:api_key/articles/trending/after/:time', to: 'articles#trending_after', defaults: {format: :json}
  get '/:api_key/articles/trending/new', to: 'articles#trending_new', defaults: {format: :json}
  root :to => 'articles#index'
end

