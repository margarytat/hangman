Rails.application.routes.draw do
  devise_for :users

  resources :games do 
  end

  resource :word_sets do 
  end

  # get "upload_words", to "upload_words"

  root 'games#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
