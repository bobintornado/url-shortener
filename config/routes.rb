Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :urls, only: [:index, :show, :create] do
      collection do
        get 'unique_visitors_stat'
      end
    end
  end
  
  get '/:short_url', to: 'app#redirect' # record request info and redirect
end
