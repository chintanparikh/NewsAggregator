ArticleAggregator::Application.routes.draw do
  resources :articles, defaults: {format: :json}
  # This is disgusting, but I couldn't find a better way to do it :(
  get '/articles/after/:id', to: 'articles#after', defaults: {format: :json}
  get '/articles/trending', to: "articles#trending", defaults: {format: :json}
  get '/articles/trending/after/:time', to: 'articles#trending_after', defaults: {format: :json}
  root :to => 'articles#index'
end

