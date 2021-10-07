Rails.application.routes.draw do
  get '/', to: 'home#index'
  get '/about', to: 'home#about'
  get '/account/signup', to: 'account#signup'
  get '/:id', to: 'profile#profile'
  get '/:id/edit', to: 'profile#edit'
  post '/:id/edit', to: 'profile#edit_post'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/account/logout', to: 'sessions#destroy'
end
