ArticleAggregator::Application.routes.draw do
  resources :articles
  get '/articles/after/:id', to: 'articles#after'
  root :to => 'articles#index'
end
