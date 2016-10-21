Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :stores
    resources :publishers
  end
end
