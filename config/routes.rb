Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup'

  root to: 'items#index'
  resources :items

  get 'search', to: 'items#search', :as => :items_search
  
  get 'stats', to: 'items#stats', :as => :item_stats
  get 'print', to: 'items#print', :as => :items_print
  get 'sell/:id', to: 'items#sell', :as => :item_sell
  get 'barcode/:id', to: 'items#barcode', :as => :item_barcode
  get 'remove/:id', to: 'items#remove', :as => :item_remove
end
