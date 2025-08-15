Rails.application.routes.draw do
  devise_for :admin, :skip => [:sessions]
  devise_for :user

  direct :rails_blob_representation do |blob, options|
    route_for(:rails_service_blob_representation, blob.signed_id, blob.filename, options)
  end

  # Defines the root path route ("/")
  root to: "home#index"

  namespace :admin, path: "administration" do

    root to: "dashboard#index"

    get   "login",         to: "authentication#login"
    post  "authenticate",  to: "authentication#authenticate"
    post  "logout",        to: "authentication#logout"
    post  "upload-csv",    to: "csv#upload"

    resources :categories do
      post "remove-image", on: :collection
      get "export_products", on: :member
    end

    resources :users
    resources :pages
    resources :posts
    resources :projects
    resources :labels
    resources :brands
    resources :availabilities
    resources :sliders
    resources :banners
    resources :settings, only: [:edit, :update]

    resources :options do
      post "add-new-item",  on: :collection
      delete "remove-item", on: :collection
    end

    resources :products do
      post "add-new-option",      on: :collection
      post "add-new-option-item", on: :collection
      post "add-new-tab",         on: :collection
      post "mass-destroy",        on: :collection
      delete "remove-image",      on: :collection
      post "move",                on: :member
    end

    namespace :orders do
      get "/",     to: "/admin/orders#index"
      get ":code", to: "/admin/orders#view", as: "view"
      delete ":code", to: "/admin/orders#destroy", as: "destroy"
    end
  end

  get "slider", to: "home#slider"
  get "home-posts", to: "home#posts"
  get "about", to: "home#about"

  match "checkout/order_fail", to: "checkout#order_fail", via: [:get, :post]
  match "checkout/order_success", to: "checkout#order_success", via: [:get, :post]

  namespace :checkout do
    get "/", to: "/checkout#index"
    post "add-to-cart"
    post "change-quantity"
    post "remove-from-cart"
    post "submit"
    get "cardlink"
  end

  post "search",          to: "search#index",       as: "search"

  namespace :feeds do
    get "sitemap"
    get "google-merchant"
  end

  post "contact/send",      to: "contact#process_send"

  localized do
    root "home#index"

    get "*slugs", to: "map#index", as: :map, constraints: lambda { |req|
      excluded_paths = [
        '/packs',
        '/rails',
        '/javascripts',
        '/stylesheets',
        '/images',
        '/fonts',
        '/favicon.ico',
        '/checkout',
        '/administration'
      ]

      excluded_paths.none? { |path| req.path.start_with?(path) }
    }, format: false
  end
end
